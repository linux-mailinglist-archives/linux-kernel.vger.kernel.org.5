Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04D7FC2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbjK1PTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbjK1PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:19:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577D1702;
        Tue, 28 Nov 2023 07:19:48 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS9C5hX030030;
        Tue, 28 Nov 2023 15:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=Zm7gFhlGOc++7Q48R9aQfql/ulMk2C2mbXeKH6ph2Rc=;
 b=kJXNMnlEV7ZeBXzYGsbAWz1PZ8vscqOXPZusxrLoshE8/Y9Ci7IH+8zkdou7wh3Di5RL
 oePHF77niflWBrnCa46wjEV18/BfzpSlgnlYTVZ+BMTbo4F0wfCqqDbBtVajuOV/ul1k
 MiwoaBMWoEaWsGtyOJluaIzFQh6gud7xehVHqnLEK4wB8AfNlLOct52nRPQt0TAP22gu
 5qdIstpTzrtlcWhW9N7yQbVof9KMflNuxewhk7M+xI9KlBUiSHdm9O7G5d3tkY4KJ1pC
 U1KkQvPVgciTXm9xGp5NSuQ1C0iAJWY5xHmReYkJBepjdD2opbHupjyBEznBPPVqC9+i 8Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3undc593br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 15:19:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASFJdS6001949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 15:19:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 07:19:39 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/3] wifi: ath: Update Qualcomm Innovation Center, Inc.
 copyrights
Date:   Tue, 28 Nov 2023 07:19:24 -0800
Message-ID: <20231128-ath12kcopyrights-v1-0-be0b7408cbac@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwEZmUC/4XNQQ6CMBCF4auQrq1hpljElfcwLupQYGIEbLGRE
 O5uYWdMZPm/ZL6ZhLeOrRenZBLOBvbctTFglwhqTFtbyWVsgSkqAMikGRrAO3X96LhuBi9JocY
 CUJNNRTzrna34vZKXa+yG/dC5cf0QYFn/YAEkyEpTqQ46NVE9P19M3NKeuodYuIBbBMpUYn6EQ
 itLdKt+CbVFqEhYKPJSZVCSgW9inucPCI8hkzgBAAA=
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T57cVo-RxCBy7Nqu7Z-nMImzD8Bd8OfE
X-Proofpoint-ORIG-GUID: T57cVo-RxCBy7Nqu7Z-nMImzD8Bd8OfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_17,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=399 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the copyright for all ath10k, ath11k, and ath12k files modified
on behalf of Qualcomm Innovation Center, Inc. in 2021 through 2023.

---
Jeff Johnson (3):
      wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath11k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights

 drivers/net/wireless/ath/ath10k/bmi.c               | 1 +
 drivers/net/wireless/ath/ath10k/ce.c                | 1 +
 drivers/net/wireless/ath/ath10k/core.c              | 1 +
 drivers/net/wireless/ath/ath10k/core.h              | 1 +
 drivers/net/wireless/ath/ath10k/coredump.c          | 1 +
 drivers/net/wireless/ath/ath10k/coredump.h          | 1 +
 drivers/net/wireless/ath/ath10k/debug.c             | 1 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c       | 1 +
 drivers/net/wireless/ath/ath10k/htc.c               | 1 +
 drivers/net/wireless/ath/ath10k/htt.h               | 1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c            | 1 +
 drivers/net/wireless/ath/ath10k/htt_tx.c            | 1 +
 drivers/net/wireless/ath/ath10k/hw.c                | 1 +
 drivers/net/wireless/ath/ath10k/hw.h                | 1 +
 drivers/net/wireless/ath/ath10k/mac.c               | 1 +
 drivers/net/wireless/ath/ath10k/pci.c               | 1 +
 drivers/net/wireless/ath/ath10k/pci.h               | 1 +
 drivers/net/wireless/ath/ath10k/qmi.c               | 1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c      | 1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h      | 1 +
 drivers/net/wireless/ath/ath10k/rx_desc.h           | 1 +
 drivers/net/wireless/ath/ath10k/sdio.c              | 1 +
 drivers/net/wireless/ath/ath10k/thermal.c           | 1 +
 drivers/net/wireless/ath/ath10k/usb.h               | 1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.h           | 1 +
 drivers/net/wireless/ath/ath10k/wmi.c               | 1 +
 drivers/net/wireless/ath/ath10k/wmi.h               | 1 +
 drivers/net/wireless/ath/ath10k/wow.c               | 1 +
 drivers/net/wireless/ath/ath11k/ce.c                | 2 +-
 drivers/net/wireless/ath/ath11k/ce.h                | 1 +
 drivers/net/wireless/ath/ath11k/dbring.c            | 1 +
 drivers/net/wireless/ath/ath11k/dbring.h            | 1 +
 drivers/net/wireless/ath/ath11k/debug.c             | 1 +
 drivers/net/wireless/ath/ath11k/debug.h             | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c           | 1 +
 drivers/net/wireless/ath/ath11k/debugfs.h           | 1 +
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c       | 1 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.h       | 1 +
 drivers/net/wireless/ath/ath11k/dp.c                | 2 +-
 drivers/net/wireless/ath/ath11k/dp.h                | 2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c             | 1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c             | 2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.h             | 1 +
 drivers/net/wireless/ath/ath11k/hal.c               | 2 +-
 drivers/net/wireless/ath/ath11k/hal.h               | 2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h          | 1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c            | 1 +
 drivers/net/wireless/ath/ath11k/hal_rx.h            | 1 +
 drivers/net/wireless/ath/ath11k/hif.h               | 1 +
 drivers/net/wireless/ath/ath11k/htc.c               | 1 +
 drivers/net/wireless/ath/ath11k/htc.h               | 1 +
 drivers/net/wireless/ath/ath11k/hw.c                | 2 +-
 drivers/net/wireless/ath/ath11k/hw.h                | 2 +-
 drivers/net/wireless/ath/ath11k/mac.h               | 1 +
 drivers/net/wireless/ath/ath11k/mhi.c               | 2 +-
 drivers/net/wireless/ath/ath11k/mhi.h               | 1 +
 drivers/net/wireless/ath/ath11k/pcic.c              | 2 +-
 drivers/net/wireless/ath/ath11k/peer.c              | 2 +-
 drivers/net/wireless/ath/ath11k/peer.h              | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.c               | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h               | 2 +-
 drivers/net/wireless/ath/ath11k/reg.c               | 1 +
 drivers/net/wireless/ath/ath11k/reg.h               | 1 +
 drivers/net/wireless/ath/ath11k/rx_desc.h           | 1 +
 drivers/net/wireless/ath/ath11k/spectral.c          | 1 +
 drivers/net/wireless/ath/ath11k/spectral.h          | 1 +
 drivers/net/wireless/ath/ath11k/thermal.c           | 1 +
 drivers/net/wireless/ath/ath11k/thermal.h           | 1 +
 drivers/net/wireless/ath/ath11k/trace.h             | 1 +
 drivers/net/wireless/ath/ath11k/wmi.c               | 2 +-
 drivers/net/wireless/ath/ath11k/wmi.h               | 2 +-
 drivers/net/wireless/ath/ath11k/wow.h               | 1 +
 drivers/net/wireless/ath/ath12k/core.c              | 2 +-
 drivers/net/wireless/ath/ath12k/core.h              | 2 +-
 drivers/net/wireless/ath/ath12k/dbring.c            | 2 +-
 drivers/net/wireless/ath/ath12k/debug.c             | 2 +-
 drivers/net/wireless/ath/ath12k/dp.c                | 2 +-
 drivers/net/wireless/ath/ath12k/dp.h                | 2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c            | 2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c             | 2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c             | 2 +-
 drivers/net/wireless/ath/ath12k/hal.c               | 2 +-
 drivers/net/wireless/ath/ath12k/hal.h               | 2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c            | 2 +-
 drivers/net/wireless/ath/ath12k/hif.h               | 2 +-
 drivers/net/wireless/ath/ath12k/hw.c                | 2 +-
 drivers/net/wireless/ath/ath12k/hw.h                | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c               | 2 +-
 drivers/net/wireless/ath/ath12k/mac.h               | 2 +-
 drivers/net/wireless/ath/ath12k/mhi.c               | 2 +-
 drivers/net/wireless/ath/ath12k/pci.c               | 2 +-
 drivers/net/wireless/ath/ath12k/pci.h               | 2 +-
 drivers/net/wireless/ath/ath12k/peer.h              | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.c               | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h               | 2 +-
 drivers/net/wireless/ath/ath12k/reg.c               | 2 +-
 drivers/net/wireless/ath/ath12k/reg.h               | 2 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h           | 2 +-
 drivers/net/wireless/ath/ath12k/wmi.c               | 2 +-
 drivers/net/wireless/ath/ath12k/wmi.h               | 2 +-
 102 files changed, 102 insertions(+), 47 deletions(-)
---
base-commit: 8f157593689fcffc2d9b18af9472fce764188b43
change-id: 20231114-ath12kcopyrights-c32629126ce0

