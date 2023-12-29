Return-Path: <linux-kernel+bounces-12956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6164181FD53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8F5B2168F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A46FA9;
	Fri, 29 Dec 2023 06:45:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7B5669;
	Fri, 29 Dec 2023 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T1bT32GJlz1Q6xP;
	Fri, 29 Dec 2023 14:44:23 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id B077418006E;
	Fri, 29 Dec 2023 14:44:51 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Dec
 2023 14:44:51 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 0/4] some updates and cleanups for hisilicon/sec2.
Date: Fri, 29 Dec 2023 14:44:17 +0800
Message-ID: <20231229064421.16981-1-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500001.china.huawei.com (7.185.36.227)

This seires patch mainly add some RAS registers to enhance the 
DFX positioning function and fix some cleanup issues.

Qi Tao (3):
  crypto: hisilicon/sec2 - updates the sec DFX function register
  crypto: hisilicon/sec2 - modify nested macro call
  crypto: hisilicon/sec2 - fix some cleanup issues

Wenkai Lin (1):
  crypto: hisilicon/sec - remove unused parameter

 drivers/crypto/hisilicon/sec2/sec_crypto.c | 33 ++++++++--------------
 drivers/crypto/hisilicon/sec2/sec_main.c   |  5 ++++
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.33.0


