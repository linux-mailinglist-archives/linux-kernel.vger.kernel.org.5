Return-Path: <linux-kernel+bounces-14113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6648217FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA75280F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E24C8F;
	Tue,  2 Jan 2024 07:28:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C2468E;
	Tue,  2 Jan 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad091032bc1a4116b2351c70b3a42695-20240102
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6b656fcb-e1da-4e6f-8427-69eae0ee4c88,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.1.35,REQID:6b656fcb-e1da-4e6f-8427-69eae0ee4c88,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:5d391d7,CLOUDID:d50b6582-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240102152741F8M6WHBH,BulkQuantity:0,Recheck:0,SF:44|66|24|72|19|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ad091032bc1a4116b2351c70b3a42695-20240102
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 440533296; Tue, 02 Jan 2024 15:27:39 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 1863A16001CD7;
	Tue,  2 Jan 2024 15:27:39 +0800 (CST)
X-ns-mid: postfix-6593BAEA-890192601
Received: from localhost.localdomain (unknown [172.20.40.222])
	by node4.com.cn (NSMail) with ESMTPA id 43A3616001CD7;
	Tue,  2 Jan 2024 07:27:37 +0000 (UTC)
From: zheng tan <tanzheng@kylinos.cn>
To: skashyap@marvell.com,
	jhasan@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com
Cc: jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng tan <tanzheng@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] scsi: qedf: fix spelling typo in comment
Date: Tue,  2 Jan 2024 15:27:35 +0800
Message-Id: <20240102072735.973345-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zheng tan <tanzheng@kylinos.cn>

fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
---
 drivers/scsi/qedf/qedf_hsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_hsi.h b/drivers/scsi/qedf/qedf_hsi.h
index ecd5cb53b750..36a8a53e859d 100644
--- a/drivers/scsi/qedf/qedf_hsi.h
+++ b/drivers/scsi/qedf/qedf_hsi.h
@@ -300,7 +300,7 @@ struct fcoe_respqe {
 /* PARAM that is located in the FCP_RSP FC header */
 #define FCOE_RESPQE_PARAM_MASK            0xFFFFFF
 #define FCOE_RESPQE_PARAM_SHIFT           0
-/* Indication whther its Target-auto-rsp mode or not */
+/* Indication whether its Target-auto-rsp mode or not */
 #define FCOE_RESPQE_TARGET_AUTO_RSP_MASK  0xFF
 #define FCOE_RESPQE_TARGET_AUTO_RSP_SHIFT 24
 };
--=20
2.27.0


