
export EDPOSE_COCO_PATH=/net/cluster/azhar/datasets/SensoryGestureRecognition/data/sensoryArt_coco_sanity
export pretrain_model_path=./models



LR=0.0001 #${LRS[$RANDOM % ${#LRS[@]}]}
WEIGHT_DECAY=0.01 #${WEIGHT_DECAYS[$RANDOM % ${#WEIGHT_DECAYS[@]}]}
LR_DROP=30 #${LR_DROPS[$i]} #${LR_DROPS[$RANDOM % ${#LR_DROPS[@]}]}
NUM_GROUP=100 #${NUM_GROUPS[$RANDOM % ${#NUM_GROUPS[@]}]}
DN_NUMBER=100 #$NUM_GROUP #${DN_NUMBERS[$RANDOM % ${#DN_NUMBERS[@]}]}
N_QUERIES=900 #$((NUM_GROUP+300)) #$((NUM_GROUP * 9))
BATCH_SIZE=2
NClASSES=17
BACKBONE='swin_L_384_22k' #'swin_L_224_22k'

EPOCH=2
# Create a run name with the combination of defined LR, weight_decay, num_group, etc.
run_name="lr${LR}_wd${WEIGHT_DECAY}_lrd${LR_DROP}_ng${NUM_GROUP}_dn${DN_NUMBER}"
# Run the command with the random values and add it to the commands array
command="python main.py  --config_file config/edpose.cfg.py --pretrain_model_path ./models/edpose_swinl_coco.pth --finetune_ignore class_embed. \
    --output_dir logs/test/edpose_finetune$i/all_coco/ \
    --options modelname=edpose num_classes=$NClASSES batch_size=$BATCH_SIZE epochs=$EPOCH lr_drop=$LR_DROP lr=$LR weight_decay=$WEIGHT_DECAY lr_backbone=1e-05 num_body_points=17 backbone=$BACKBONE \
    set_cost_class=2.0 cls_loss_coef=2.0 use_dn=True dn_number=$DN_NUMBER num_queries=$N_QUERIES num_group=$NUM_GROUP \
    --dataset_file=coco \
    --fix_size \
    --note $run_name"

eval $command