Return-Path: <linux-kernel+bounces-7762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489681ACC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090511F23C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67935239;
	Thu, 21 Dec 2023 02:54:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FF4685;
	Thu, 21 Dec 2023 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8da60cfefa5d40bdb114173e7c6cacfb-20231221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:0e5c146c-6213-436d-b6ba-cc218d39367c,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.1.33,REQID:0e5c146c-6213-436d-b6ba-cc218d39367c,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:364b77b,CLOUDID:90a8807e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:231221105415YJZT1OCP,BulkQuantity:0,Recheck:0,SF:72|19|44|66|24|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8da60cfefa5d40bdb114173e7c6cacfb-20231221
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2120933743; Thu, 21 Dec 2023 10:54:12 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id E5FA916001CD7;
	Thu, 21 Dec 2023 10:54:11 +0800 (CST)
X-ns-mid: postfix-6583A8D3-82063953
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 8AE8616001CD7;
	Thu, 21 Dec 2023 02:54:11 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] drivers/scsi/mpt3sas/mpt3sas_warpdrive.c: Fix spelling typo in comment
Date: Thu, 21 Dec 2023 10:53:28 +0800
Message-Id: <20231221025328.1318264-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: liyouhong <liyouhong@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

diff --git a/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c b/drivers/scsi/mpt3=
sas/mpt3sas_warpdrive.c
index cc07ba41f507..2d35a5948bf3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
@@ -250,7 +250,7 @@ mpt3sas_init_warpdrive_properties(struct MPT3SAS_ADAP=
TER *ioc,
  * @ioc: per adapter object
  * @scmd: pointer to scsi command object
  * @raid_device: pointer to raid device data structure
- * @mpi_request: pointer to the SCSI_IO reqest message frame
+ * @mpi_request: pointer to the SCSI_IO request message frame
  */
 void
 mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *s=
cmd,
--=20
2.34.1


