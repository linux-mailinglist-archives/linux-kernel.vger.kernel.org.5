Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324A47F96F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjK0A6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjK0A6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:58:32 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA8119;
        Sun, 26 Nov 2023 16:58:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vx7PgGb_1701046714;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vx7PgGb_1701046714)
          by smtp.aliyun-inc.com;
          Mon, 27 Nov 2023 08:58:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     matthias.bgg@gmail.com, mchehab@kernel.org,
        yunfei.dong@mediatek.com, andrew-ct.chen@mediatek.com,
        tiffany.lin@mediatek.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: mediatek: vcodec: Remove unneeded semicolon
Date:   Mon, 27 Nov 2023 08:58:33 +0800
Message-Id: <20231127005833.105870-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:569:2-3: Unneeded semicolon
./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:583:2-3: Unneeded semicolon
./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:599:2-3: Unneeded semicolon
./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:613:2-3: Unneeded semicolon
./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:633:2-3: Unneeded semicolon
./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:647:2-3: Unneeded semicolon
./drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c:683:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7632
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index d54b3833790d..b903e39fee89 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -566,7 +566,7 @@ static void mtk_vcodec_dec_fill_h264_level(struct v4l2_ctrl_config *cfg,
 	default:
 		cfg->max = V4L2_MPEG_VIDEO_H264_LEVEL_4_1;
 		break;
-	};
+	}
 }
 
 static void mtk_vcodec_dec_fill_h264_profile(struct v4l2_ctrl_config *cfg,
@@ -580,7 +580,7 @@ static void mtk_vcodec_dec_fill_h264_profile(struct v4l2_ctrl_config *cfg,
 	default:
 		cfg->max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH;
 		break;
-	};
+	}
 }
 
 static void mtk_vcodec_dec_fill_h265_level(struct v4l2_ctrl_config *cfg,
@@ -596,7 +596,7 @@ static void mtk_vcodec_dec_fill_h265_level(struct v4l2_ctrl_config *cfg,
 	default:
 		cfg->max = V4L2_MPEG_VIDEO_HEVC_LEVEL_4;
 		break;
-	};
+	}
 }
 
 static void mtk_vcodec_dec_fill_h265_profile(struct v4l2_ctrl_config *cfg,
@@ -610,7 +610,7 @@ static void mtk_vcodec_dec_fill_h265_profile(struct v4l2_ctrl_config *cfg,
 	default:
 		cfg->max = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE;
 		break;
-	};
+	}
 }
 
 static void mtk_vcodec_dec_fill_vp9_level(struct v4l2_ctrl_config *cfg,
@@ -630,7 +630,7 @@ static void mtk_vcodec_dec_fill_vp9_level(struct v4l2_ctrl_config *cfg,
 	default:
 		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_4_0;
 		break;
-	};
+	}
 }
 
 static void mtk_vcodec_dec_fill_vp9_profile(struct v4l2_ctrl_config *cfg,
@@ -644,7 +644,7 @@ static void mtk_vcodec_dec_fill_vp9_profile(struct v4l2_ctrl_config *cfg,
 	default:
 		cfg->max = V4L2_MPEG_VIDEO_VP9_PROFILE_1;
 		break;
-	};
+	}
 }
 
 static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
@@ -680,7 +680,7 @@ static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
 		break;
 	default:
 		break;
-	};
+	}
 }
 
 static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
-- 
2.20.1.7.g153144c

