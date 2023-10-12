Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197D7C6284
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJLCBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjJLCBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:01:15 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE0A9;
        Wed, 11 Oct 2023 19:01:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VtyWj9M_1697076068;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VtyWj9M_1697076068)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:01:10 +0800
Message-ID: <f06fbb72-dbea-6bfa-e5a0-337567708e7b@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 10:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To:     Chao Yu <chao@kernel.org>, Tiwei Bie <tiwei.btw@antgroup.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
 <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
 <1a4d325b-d3a8-121b-1118-934fafcc8ebe@kernel.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1a4d325b-d3a8-121b-1118-934fafcc8ebe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2023/10/12 09:10, Chao Yu wrote:
> On 2023/10/10 21:06, Gao Xiang wrote:
>>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Looks fine to me for the version in dev-test branch.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Yeah, thanks! I will add the tag when applying to -next.

Thanks,
Gao Xiang

> 
> Thanks,
