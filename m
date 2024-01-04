Return-Path: <linux-kernel+bounces-16346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 246ED823D15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C3AB231C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF3200BD;
	Thu,  4 Jan 2024 07:59:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE82032A;
	Thu,  4 Jan 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T5Jph0ndDz29hsv;
	Thu,  4 Jan 2024 15:57:32 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (unknown [7.193.23.191])
	by mail.maildlp.com (Postfix) with ESMTPS id AEEB41A0173;
	Thu,  4 Jan 2024 15:58:58 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:58:58 +0800
Subject: Re: [PATCH v2 0/4] some updates and cleanups for hisilicon/sec2.
To: Qi Tao <taoqi10@huawei.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20231229064421.16981-1-taoqi10@huawei.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <ce0455d4-49c7-4838-a774-e7834aac5904@huawei.com>
Date: Thu, 4 Jan 2024 15:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231229064421.16981-1-taoqi10@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)

On 2023/12/29 14:44, Qi Tao wrote:
> This seires patch mainly add some RAS registers to enhance the 
> DFX positioning function and fix some cleanup issues.
> 
> Qi Tao (3):
>   crypto: hisilicon/sec2 - updates the sec DFX function register
>   crypto: hisilicon/sec2 - modify nested macro call
>   crypto: hisilicon/sec2 - fix some cleanup issues
> 
> Wenkai Lin (1):
>   crypto: hisilicon/sec - remove unused parameter
> 
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 33 ++++++++--------------
>  drivers/crypto/hisilicon/sec2/sec_main.c   |  5 ++++
>  2 files changed, 17 insertions(+), 21 deletions(-)
> 

Reviewed-by: Longfang Liu <liulongfang@huawei.com>

Thanks,
Longfang.

