Return-Path: <linux-kernel+bounces-13972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B4D82162F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61486B21313
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABFEC4;
	Tue,  2 Jan 2024 01:54:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4AA3C;
	Tue,  2 Jan 2024 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1aea85f17682422dac81e619213c3012-20240102
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:590e7556-0f26-42e5-8799-18154acd262f,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.1.35,REQID:590e7556-0f26-42e5-8799-18154acd262f,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:5d391d7,CLOUDID:0a5dc88d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240102095434KIT3K19G,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1aea85f17682422dac81e619213c3012-20240102
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 589800547; Tue, 02 Jan 2024 09:54:31 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 9885F16001CD7;
	Tue,  2 Jan 2024 09:54:30 +0800 (CST)
X-ns-mid: postfix-65936CD6-418672167
Received: from localhost.localdomain (unknown [172.20.40.222])
	by node4.com.cn (NSMail) with ESMTPA id CA2BF16001CD7;
	Tue,  2 Jan 2024 01:54:24 +0000 (UTC)
From: zheng tan <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng tan <tanzheng@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH 3/5] net: mac80211: fix spelling typo in comment
Date: Tue,  2 Jan 2024 09:54:18 +0800
Message-Id: <20240102015418.3673858-1-tanzheng@kylinos.cn>
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
 net/mac80211/debugfs_sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 5bf507ebb096..1e9389c49a57 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -16,7 +16,7 @@
 #include "sta_info.h"
 #include "driver-ops.h"
=20
-/* sta attributtes */
+/* sta attributes */
=20
 #define STA_READ(name, field, format_string)				\
 static ssize_t sta_ ##name## _read(struct file *file,			\
--=20
2.34.1


