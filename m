Return-Path: <linux-kernel+bounces-7876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B281AE95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E811C22F80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2092AB669;
	Thu, 21 Dec 2023 05:59:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F39B641;
	Thu, 21 Dec 2023 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp75t1703138317tn34i1sc
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Dec 2023 13:58:35 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: nA8mzCjPbKhGBn850sgwajtUoZgKOipjl+h8F581A/U2+hRYQkbNcWxNRxow0
	apbv73toR/zQqt2GGAA5mM21WzAVvDatAK2HNZZD6zJpe/A+Z2Mtpc32+rVpapci+0+wmtL
	pUz3N6rERb2me6XbELidjMV5/YjqYlZ4D5Bce2WD+zhs6viEBOgqSRkxLlBuvNxv9OqgUJj
	yQQMxPsNyCEaNPDPx7TaF5OLfOQEyo3sY5eYbzV3/a2isEN+cdKaRoJTQQBbgwuWxFSGB0M
	GR186SNKaIIBkcC7HVrBBRMpYyJfsWZVux6Mpbu4hmXjj/Tj3eE7xz1gjsfQF9VKHp4KHHB
	ksnk8nFYpJv7oxTkjlJ8YcBjd4Q2a65btgzbHJMLgJ83M/uZezkrhxRWnpwYENE0B0Ea0KH
	h91AgqX/qEHn809BUI9HCsLUCyP+arVX
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4987725630253096874
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: shenghui.qu@shingroup.cn,
	ke.zhao@shingroup.cn,
	zhijie.ren@shingroup.cn,
	"JiaLong.Yang" <jialong.yang@shingroup.cn>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
Date: Thu, 21 Dec 2023 13:58:32 +0800
Message-Id: <20231221055832.4374-1-jialong.yang@shingroup.cn>
In-Reply-To: <340cbb78-3e68-4584-8e11-313f7f86fd34@loongson.cn>
References: 
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

We know the macro DEBUG will make pr_debug() save the formatted
string into final binary. But the translation in chinese gives a
opposite meaning.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
link: https://lore.kernel.org/lkml/a9cbebd8-dd6e-d81c-471f-f40dcc7196ea@linux.dev/
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
link: https://lore.kernel.org/lkml/340cbb78-3e68-4584-8e11-313f7f86fd34@loongson.cn/
Acked-by: Yanteng Si <siyanteng@loongson.cn>
---

V2: add commit info.
Maybe now I have known about the process of patch.
Sorry for wasting time of yours.

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


