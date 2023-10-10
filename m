Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418E7BFE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjJJNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjJJNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:41:46 -0400
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1391705;
        Tue, 10 Oct 2023 06:39:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.Uxbr70Y_1696945180;
Received: from 30.239.222.1(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Uxbr70Y_1696945180)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 21:39:49 +0800
Message-ID: <78478a20-e617-468c-85e6-105b16e6723b@antgroup.com>
Date:   Tue, 10 Oct 2023 21:39:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
 <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
Content-Language: en-US
From:   "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 9:06 PM, Gao Xiang wrote:
>> Fixes: fdb0536469cb ("staging: erofs: add document")
> 
> I'm not sure if it's necessary to tag document fixes anyway
> since docs.kernel.org already uses the latest version and
> `.rst` format is adapted much later..
> 
> I will drop this tag for the next merge window if not urgent.

Thanks! This patch is not urgent. :)

Regards,
Tiwei
