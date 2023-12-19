Return-Path: <linux-kernel+bounces-4785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E33818202
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D32F1C23290
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B911728;
	Tue, 19 Dec 2023 07:09:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE5F9E7;
	Tue, 19 Dec 2023 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1702969713tcg33gvg
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Dec 2023 15:08:31 +0800 (CST)
X-QQ-SSF: A0400000000000B0B000000A0000000
X-QQ-FEAT: 7jw2iSiCazpTuf3ufex+zEZe9A3pw00ThJB+7xmzyuM0CKEdN4CCp2/95iL+l
	gi0O8Rh90UjemHU5EyxxRFM7qmxcAhmELo7vtJBG9gvoqU91ErNV21DO7eRaemURBBjO9VV
	9TgBtV7wWJiHalLlIpXHl7WjiQ+MYMP0vaCosGGwbPR7C2MepKLKN9w+KrMKAFlf48jw2p/
	MLaxo28Nsb0iL+hg8TxuTKvEHB4IU1+a9wn/bK+VbQ1I0k6MTMlnJEOwKPcWGDFxw4bFx69
	Xt4Gf1I6Vn/QUWbi7ts+luK0UoxJJrrkXmPIdccjOzrE2yT5zndNbnRhsq+udqzuNLYx696
	UARMdXxt8bHlVLw8MAb63u8+zd3sUJpjRQhTE1HFSFHiw/M8Z9obk9dhNdWjAA6Oh9wCg1m
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4276673365079671435
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: 2738078698@qq.com,
	"JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
Date: Tue, 19 Dec 2023 15:08:13 +0800
Message-Id: <20231219070813.29161-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
---
 Documentation/translations/zh_CN/core-api/printk-basics.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/core-api/printk-basics.rst b/Documentation/translations/zh_CN/core-api/printk-basics.rst
index 59c6efb3fc41..cafa01bccff2 100644
--- a/Documentation/translations/zh_CN/core-api/printk-basics.rst
+++ b/Documentation/translations/zh_CN/core-api/printk-basics.rst
@@ -100,7 +100,7 @@ printk()的用法通常是这样的::
 
 为了调试，还有两个有条件编译的宏：
 pr_debug()和pr_devel()，除非定义了 ``DEBUG`` (或者在pr_debug()的情况下定义了
-``CONFIG_DYNAMIC_DEBUG`` )，否则它们会被编译。
+``CONFIG_DYNAMIC_DEBUG`` )，否则它们不会被编译。
 
 
 函数接口
-- 
2.25.1


