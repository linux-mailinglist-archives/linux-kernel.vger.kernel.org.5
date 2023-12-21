Return-Path: <linux-kernel+bounces-7931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2681AF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D24A1C2087B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24C168DA;
	Thu, 21 Dec 2023 07:24:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9ED168B4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VywtuYY_1703143479;
Received: from 30.97.48.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VywtuYY_1703143479)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 15:24:40 +0800
Message-ID: <5f84ba39-3829-456a-99a2-098f59a9539e@linux.alibaba.com>
Date: Thu, 21 Dec 2023 15:24:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: allow partially filled compressed bvecs
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Cc: jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>
References: <20231221062341.23901-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231221062341.23901-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/21 14:23, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> In order to reduce memory footprints even further, let's allow
> partially filled compressed bvecs for readahead to bail out later.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

