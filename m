Return-Path: <linux-kernel+bounces-6211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF508195F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D1284374
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B523B8;
	Wed, 20 Dec 2023 00:51:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6B6133;
	Wed, 20 Dec 2023 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VysB-8d_1703033504;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VysB-8d_1703033504)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 08:51:45 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: fabrice.gasnier@foss.st.com,
	william.gray@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] tools/counter: Remove unneeded semicolon
Date: Wed, 20 Dec 2023 08:51:43 +0800
Message-Id: <20231220005143.84987-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/counter/counter_watch_events.c:233:3-4: Unneeded semicolon
./tools/counter/counter_watch_events.c:234:2-3: Unneeded semicolon
./tools/counter/counter_watch_events.c:333:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7782
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/counter/counter_watch_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
index 3898fe7e35ec..2ce4c99ebd01 100644
--- a/tools/counter/counter_watch_events.c
+++ b/tools/counter/counter_watch_events.c
@@ -230,8 +230,8 @@ int main(int argc, char **argv)
 			break;
 		default:
 			return EXIT_FAILURE;
-		};
-	};
+		}
+	}
 
 	if (nwatch) {
 		watches = calloc(nwatch, sizeof(*watches));
@@ -330,7 +330,7 @@ int main(int argc, char **argv)
 			i++;
 			break;
 		}
-	};
+	}
 
 	if (debug)
 		print_watch(watches, nwatch);
-- 
2.20.1.7.g153144c


