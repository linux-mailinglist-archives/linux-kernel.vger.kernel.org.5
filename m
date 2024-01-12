Return-Path: <linux-kernel+bounces-24250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA582B9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18AF1C262F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289815C6;
	Fri, 12 Jan 2024 02:55:02 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A113AE9;
	Fri, 12 Jan 2024 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-RM2W3_1705028095;
Received: from 30.221.130.160(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-RM2W3_1705028095)
          by smtp.aliyun-inc.com;
          Fri, 12 Jan 2024 10:54:56 +0800
Message-ID: <44bda499-8bd7-4382-913e-6948d722bcd1@linux.alibaba.com>
Date: Fri, 12 Jan 2024 10:54:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Simon Horman <horms@kernel.org>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111133609.GC45291@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240111133609.GC45291@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/11 21:36, Simon Horman wrote:
> On Thu, Jan 11, 2024 at 08:00:21PM +0800, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The
>> first part can be referred from [2]), the updated things of this version
>> are listed at the end.
> 
> ...
> 
> Hi Wen Gu,
> 
> unfortunately net-next is currently closed.
> 
> [adapted from text by Jakub]
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.8 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens on or after 21st January.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer

Thank you for notifying, Simon. I will follow the development-cycle. Thanks again.

