Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED47DBC18
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjJ3Ouf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjJ3Oud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:50:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457FFC2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:50:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC56C433C7;
        Mon, 30 Oct 2023 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698677429;
        bh=Lq3kUlbKODK3hpI0ykMHy/CoeP2mot4776pgkJO0T1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q6Z7Mrmq5c4vvIr47jfTjs9fdgEa++nxwoO9Bf2u8e37HFW2+2KorqY/7h8lqm428
         fS6UZKX/tKN63ZhJs01OjeQ+6+DsAP6csmXTLrgiA+T+EUZSJ/haAe2/b4DY5lnVYI
         j+rWINl2eAcywmAgsJ01ACcmCQlwI8SwNPnY9mOyJZyBq0QZzjP1RDwGWKcNw5Jh0f
         F72zQK1BnujuzswhhEdOre0NwjOZRBbczJiAvXzxMTq8ZyW7NJ+MhaH5hMOoY/nY80
         uMNKsCqLTcqw6GkBDb4yrIDWdyvu9AnFVwt7EroRZIY6C0Qkz+6wMsQxgNkIuq4+c/
         S06GXugMAg2Bw==
Message-ID: <c5450fd8-d4da-bbf9-006e-33428506bc2b@kernel.org>
Date:   Mon, 30 Oct 2023 22:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] erofs: don't warn MicroLZMA format anymore
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231021020137.1646959-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231021020137.1646959-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/21 10:01, Gao Xiang wrote:
> The LZMA algorithm support has been landed for more than one year since
> Linux 5.16.  Besides, the new XZ Utils 5.4 has been available in most
> Linux distributions.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
