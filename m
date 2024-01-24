Return-Path: <linux-kernel+bounces-37016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78083AA35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827411F231BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9957763D;
	Wed, 24 Jan 2024 12:45:14 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C57C081
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100314; cv=none; b=Cpq47kBqBMaisN5qdP/cKorxlZDhD+m76v921Es2EQtXxxvKVNCNm+7gAMGEXEquYvT1THeLqcf0G2D1/yi0w2A54NzLDJ3jZRzXBElrtuw9HLfzl9Bue7t5nPg2K/M6/lUq1qOqiDci8+v2EZImND2DdhbHamg/oLjSF3/+OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100314; c=relaxed/simple;
	bh=qWmXvQURcZYGW+gqIxnMRcfmBaG8y36oBWYaQud2e74=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lGV6U6n/SDahbYixdSIBOMXvHmgeMkDp4Wh8V+vGfUPvW3ypcOglHDtAyYXP2czL1BAHC6mJ+ka5n0Trw0nNvPQs8/O3kjQTvD5Lzlv38sUKA81s8sTXNifj2qwkFdyVJSYK9VzZKMBwqy1n7w3YdTUaOZfdzvDpsDmKTUzjaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TKkDL1Rz5z1xmWl;
	Wed, 24 Jan 2024 20:44:18 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B386B140414;
	Wed, 24 Jan 2024 20:45:10 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 20:45:10 +0800
Subject: Re: [PATCH] MAINTAINERS: Add Zhihao Cheng as UBI/UBIFS reviewer
To: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240124092246.9616-1-richard@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7e25b80c-99a9-cbde-7744-7fc264e6eb1c@huawei.com>
Date: Wed, 24 Jan 2024 20:45:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240124092246.9616-1-richard@nod.at>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/1/24 17:22, Richard Weinberger Ð´µÀ:
> Recognizing Zhihao Cheng's valuable contributions,
> let's officially appoint him as a UBI/UBIFS reviewer.
> His demonstrated expertise and assistance make him a valuable
> addition to the MTD community.
> 
> Cc: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Zhihao Cheng,
> 
> Please ack this patch if you're fine with this change.

Thanks a lot for the approval from Richard, it's my honor to take on 
this responsibility.

Acked-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> Thanks,
> //richard
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..fc99cc381268 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22453,6 +22453,7 @@ F:	include/uapi/misc/uacce/
>   
>   UBI FILE SYSTEM (UBIFS)
>   M:	Richard Weinberger <richard@nod.at>
> +R:	Zhihao Cheng <chengzhihao1@huawei.com>
>   L:	linux-mtd@lists.infradead.org
>   S:	Supported
>   W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
> @@ -22581,6 +22582,7 @@ F:	drivers/ufs/host/ufs-renesas.c
>   
>   UNSORTED BLOCK IMAGES (UBI)
>   M:	Richard Weinberger <richard@nod.at>
> +R:	Zhihao Cheng <chengzhihao1@huawei.com>
>   L:	linux-mtd@lists.infradead.org
>   S:	Supported
>   W:	http://www.linux-mtd.infradead.org/
> 


