Return-Path: <linux-kernel+bounces-144500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B18A4725
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED62F1C20AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EB1BC46;
	Mon, 15 Apr 2024 02:55:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088B14F6C;
	Mon, 15 Apr 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149729; cv=none; b=r8hRZnatesnH8c4E6C9zl/NvbshKzWUh8qpHHYLD4S+3rQttVdhLGItRwvQq/jOiyz1cj/5QEL9djwHKRtM5D8YH6VkFnAwEeeVCQmwiXCJ2GxxQs+3F0AXaYakfIePa64s3J+sTEicgI075XOKOvVJoYw43mwtGJC2mXDY2GzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149729; c=relaxed/simple;
	bh=RPuddjlM3XrY9Du0GUl5WtMe7Q8iXCsEHOKgJCXqSb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IvBPKG4CHUO47b48t3A+FeIVSe112vb7cEFNIBJjFl4EDEPNl5u3GW0ALzRZxijQSgEWq1NbPNr7G/MuP+90+ZzbtFbvRcpS/lx5TPkhJx1pJ5L0cufZyv2ZBgBudneDEnLL6gsJ1n0tuv0YK2Si/RxpP5Nfc49TJSkqO75ZgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VHsCc1nwsz1hwPX;
	Mon, 15 Apr 2024 10:52:28 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 19049140383;
	Mon, 15 Apr 2024 10:55:24 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:55:23 +0800
Message-ID: <66546f2a-1fab-4115-8ff5-27e8aec276f1@huawei.com>
Date: Mon, 15 Apr 2024 10:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: remove unneeded semicolon
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	<kent.overstreet@linux.dev>
CC: <bfoster@redhat.com>, <linux-bcachefs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>
References: <20240415023557.5851-1-jiapeng.chong@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240415023557.5851-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

I remember other people also submit this likely patch:

https://lore.kernel.org/linux-bcachefs/20240103010720.39784-1-yang.lee@linux.alibaba.com/

https://lore.kernel.org/linux-bcachefs/20240103095942.3982021-1-lihongbo22@huawei.com/

On 2024/4/15 10:35, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./fs/bcachefs/super.c:1128:59-60: Unneeded semicolon.
> ./fs/bcachefs/super.c:1133:59-60: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8755
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   fs/bcachefs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index 8daf80a38d60..234f19ea8f30 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -1125,12 +1125,12 @@ static int bch2_dev_in_fs(struct bch_sb_handle *fs,
>   
>   		prt_bdevname(&buf, fs->bdev);
>   		prt_char(&buf, ' ');
> -		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));;
> +		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));
>   		prt_newline(&buf);
>   
>   		prt_bdevname(&buf, sb->bdev);
>   		prt_char(&buf, ' ');
> -		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));;
> +		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));
>   		prt_newline(&buf);
>   
>   		if (!opts->no_splitbrain_check)

