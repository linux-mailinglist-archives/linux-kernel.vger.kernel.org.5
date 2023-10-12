Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712017C6214
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjJLBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:10:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CEA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:10:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B22C433C7;
        Thu, 12 Oct 2023 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697073035;
        bh=gDcWvd8c83WQi7qJGHm8pS0oFCedA+sEFdt+1He8YaY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lIlRMdV4Ocyyam4qLfeDwCPtPPdzUdXgtqFQSwMMoEgqAcw6BMdxgC4TujVYPtS48
         e/k+5OdxKzd243XfclE9qcObso99i+3k0kUzfCXH2XmyKUt/7RUk8scQUjfZKGpBw4
         p3sIASpbPm8QNgjAftxjMEqz0X8veDr2e4iAm7/qx2sQ5Eq7Bv2pqZALx7huDf6zqE
         vzN+OJXnLNoJcyVXjbt3RVomwvLf3dMQn2PB9rdzHrq2bUM1IUnmH4fuBfqSsUBjLA
         u6i695+CrJ3VigSi9E4sdvKuZ/0iTuCQpFCzRgdcBjl6D53WZc6sNoLiMjI/cgryRv
         KLB6M1ehLULqg==
Message-ID: <1a4d325b-d3a8-121b-1118-934fafcc8ebe@kernel.org>
Date:   Thu, 12 Oct 2023 09:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Tiwei Bie <tiwei.btw@antgroup.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
 <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/10 21:06, Gao Xiang wrote:
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Looks fine to me for the version in dev-test branch.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
