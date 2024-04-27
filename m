Return-Path: <linux-kernel+bounces-160910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127268B4469
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2760E1C221B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43E40847;
	Sat, 27 Apr 2024 05:38:07 +0000 (UTC)
Received: from hust.edu.cn (unknown [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8181E4A8;
	Sat, 27 Apr 2024 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714196286; cv=none; b=nDYSYbdf0lWFDmkNH671vsUioOgSxASMs1LaAfZT4TiNmXHhI66FSrx7U9HMp/+J79BWE/L72p2jgA6PhJEZR1Sqbfbw0EYo6fXbV7jC2b+5OORU5uzowaXFlwxjDYWPpKAJ85Gnze4EeiDbSBAUJasGkYsB5HwUVdJcIgVJCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714196286; c=relaxed/simple;
	bh=iO6uCBxvEkuj7AfpMsgerSOpQQfvTsqL9ARBUK5sltQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FUdyXPOw7YlImMxvEM2GWLdQ3VF0UconSwB0G8UfUaJVYja+S7DAxFwONWmquvM6PRQSUG+dfaQSuVhq5xO6yt/w1ThUSxU5L7QzvA4h6BKFJtZ/MaTgLIT+vg5xVMjF1eIZlA/HrZHLB8q0su9FUHGEx+dM6Y0woie7P39Iscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAB3f_sIjyxm+0oKAQ--.48584S2;
	Sat, 27 Apr 2024 13:37:12 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wBnTy0BjyxmsW07AQ--.35593S2;
	Sat, 27 Apr 2024 13:37:11 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: remove two inconsistent spaces
Date: Sat, 27 Apr 2024 13:37:02 +0800
Message-Id: <20240427053703.2339727-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3f_sIjyxm+0oKAQ--.48584S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4DCFWUWF18Zry7CrykKrg_yoW8GFWUpF
	12g34fKa48ZF15CryagFy7Zr17Ga4xKa18KF18W3WSqrZ3XrZYqF4DtFZ0qFnFqrWfZFWU
	XrW2kF9Yg34jvrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Ar1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04
	k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvj4REiiSUUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

The spaces on the left and right of texts should be consistent.
Remove these redundent spaces.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 6ccec9657cc6..20b9d4270d1f 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -24,8 +24,8 @@
 上的linux-doc邮件列表。
 
 顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
-的字符标点占用两个英文字符宽度， 所以，当英文要求不要超过每行100个字符时，
-中文就不要超过50个字符。另外，也要注意'-'，'=' 等符号与相关标题的对齐。在将
+的字符标点占用两个英文字符宽度，所以，当英文要求不要超过每行100个字符时，
+中文就不要超过50个字符。另外，也要注意'-'，'='等符号与相关标题的对齐。在将
 补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试。
 
 与Linux 内核社区一起工作
-- 
2.34.1


