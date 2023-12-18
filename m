Return-Path: <linux-kernel+bounces-3076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 941DD8166FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A8DB219AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98881C8C6;
	Mon, 18 Dec 2023 07:04:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589328473;
	Mon, 18 Dec 2023 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4StrLx5ZQ7z9xpFj;
	Mon, 18 Dec 2023 15:00:41 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 18 Dec
 2023 15:04:07 +0800
Date: Mon, 18 Dec 2023 15:04:07 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH net-next v2] octeontx2-af: insert space after include
Message-ID: <202312181459+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

Maintain Consistent Formatting: Insert Space after #include

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
V2:
    In accordance with Jakub's advice, modify the patch title.

V1: https://lore.kernel.org/all/20231215181043.4ed733cf@kernel.org/

 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 62780d8b4f9a..97a8039750c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -5,7 +5,7 @@
  *
  */
 
-#include<linux/bitfield.h>
+#include <linux/bitfield.h>
 
 #include "rvu.h"
 #include "rvu_reg.h"
-- 
2.40.0


