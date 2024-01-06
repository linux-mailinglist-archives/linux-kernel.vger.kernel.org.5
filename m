Return-Path: <linux-kernel+bounces-18526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC7825EBB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230D5B22BEC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14A5232;
	Sat,  6 Jan 2024 07:41:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51312440D;
	Sat,  6 Jan 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yilin.li@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W-0zWHn_1704526879;
Received: from 30.221.132.184(mailfrom:YiLin.Li@linux.alibaba.com fp:SMTPD_---0W-0zWHn_1704526879)
          by smtp.aliyun-inc.com;
          Sat, 06 Jan 2024 15:41:33 +0800
Message-ID: <5f908530-564a-2778-9bc8-72bbf6475255@linux.alibaba.com>
Date: Sat, 6 Jan 2024 15:41:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] crypto: asymmetric_keys/pkcs7.asn1 - remove the
 duplicated contentType pkcs7_note_OID processing logic
To: David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tianjia.zhang@linux.alibaba.com, YiLin.Li@linux.alibaba.com
References: <20231111055553.103757-1-YiLin.Li@linux.alibaba.com>
 <99c010f0-3bb1-1e67-4184-6b0ce312b232@linux.alibaba.com>
From: "YiLin.Li" <YiLin.Li@linux.alibaba.com>
In-Reply-To: <99c010f0-3bb1-1e67-4184-6b0ce312b232@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

gently ping...

在 2023/12/1 15:44, YiLin.Li 写道:
> gently ping...

