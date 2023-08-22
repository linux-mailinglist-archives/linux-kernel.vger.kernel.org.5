Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C107844B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjHVOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjHVOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:51:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE661BE;
        Tue, 22 Aug 2023 07:51:00 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MCi54I015178;
        Tue, 22 Aug 2023 14:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=bHpBcfydAA/FQ9/KVYQ/NasYt+qP7kxdQqF/eVbjYUU=;
 b=cJ9F8pSII3hb5Dk3KG42O16La/vSp6Oj23Ydp/j3adEeB/qXrBA/GCAj5WWRrHRQ9Gd5
 IGrCyiyLd7Hf8u3MyMzL7VkEDMWRD16mEFFNMDbwJw+ZX1Fv1Om0z1TjlR5qrnauDyvp
 0B+qAYjMFGU2rxD4SPcfdpGVRl/lONmBRYBLNM+KhIjEDN5b9fwKxSZo/MllCYGZCg/R
 H6O1YB89RduD6k1nqebwLyo6wisOnMnGzxQkV6zEnTzBEC21gHZMaPP5V2+5SNNFW0OC
 FHT3rpE+1OTVR73KgCaJ9JtvTouPAEo8SYJHCj6DJaYMCOsS1Wj4uOPNjnaNxBxjXKV9 Lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smasmt8v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:50:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MEop3i023950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:50:51 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 07:50:51 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 22 Aug 2023 07:50:50 -0700
Subject: [PATCH 3/3] wifi: ath12k: Fix a few spelling errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230822-ath_spelling-v1-3-8e2698759564@quicinc.com>
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
In-Reply-To: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yo4smiRTOXq6dKysmvE0qQ9peD9y3ebO
X-Proofpoint-GUID: yo4smiRTOXq6dKysmvE0qQ9peD9y3ebO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few issues flagged by 'codespell'.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h      | 2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 2 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7c5dafce5a68..6e7b7281d549 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -712,7 +712,7 @@ enum htt_stats_internal_ppdu_frametype {
  *          b'24    - status_swap: 1 is to swap status TLV
  *          b'25    - pkt_swap:  1 is to swap packet TLV
  *          b'26:31 - rsvd1:  reserved for future use
- * dword1 - b'0:16  - ring_buffer_size: size of bufferes referenced by rx ring,
+ * dword1 - b'0:16  - ring_buffer_size: size of buffers referenced by rx ring,
  *                    in byte units.
  *                    Valid only for HW_TO_SW_RING and SW_TO_HW_RING
  *        - b'16:31 - rsvd2: Reserved for future use
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 67f8c140840f..e6e64d437c47 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3027,7 +3027,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 					desc_info->cookie,
 					HAL_RX_BUF_RBM_SW3_BM);
 
-	/* Fill mpdu details into reo entrace ring */
+	/* Fill mpdu details into reo entrance ring */
 	srng = &ab->hal.srng_list[dp->reo_reinject_ring.ring_id];
 
 	spin_lock_bh(&srng->lock);
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index d661fe586651..8874c815d7fa 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -301,7 +301,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 		spin_unlock_bh(&tcl_ring->lock);
 		ret = -ENOMEM;
 
-		/* Checking for available tcl descritors in another ring in
+		/* Checking for available tcl descriptors in another ring in
 		 * case of failure due to full tcl ring now, is better than
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0f2af2f14ef7..dbaf033c2527 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6771,7 +6771,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			/* After trigger disconnect, then upper layer will
 			 * trigger connect again, then the PN number of
 			 * upper layer will be reset to keep up with AP
-			 * side, hence PN number mis-match will not happened.
+			 * side, hence PN number mismatch will not happened.
 			 */
 			if (arvif->is_up &&
 			    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index f99556a253e5..bfa87cb8d021 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -221,7 +221,7 @@ struct rx_mpdu_start_qcn9274 {
  *		PPE routing even if RXOLE CCE or flow search indicate 'Use_PPE'
  *		This is set by SW for peers which are being handled by a
  *		host SW/accelerator subsystem that also handles packet
- *		uffer management for WiFi-to-PPE routing.
+ *		buffer management for WiFi-to-PPE routing.
  *
  *		This is cleared by SW for peers which are being handled
  *		by a different subsystem, completely disabling WiFi-to-PPE

-- 
2.25.1

