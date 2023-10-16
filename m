Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D07C9D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjJPDKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:10:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2996BAD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:10:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE584C433C8;
        Mon, 16 Oct 2023 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697425802;
        bh=JghYXrcoMAqHEKfXw+VbbXNee2KQVS0xzE7UpviVuIY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GS2NVBLbadbFKW81qioBYDfgMgbzNuIJxVPx6yx+OffzdT3bQJ0APB1N31mheY8I9
         NPntwkZ2x+gwDzLaAD1JQIfsXOTWpahmsbZ8CT7RusRFqTUw53XXmFkcGEAzvHYe9p
         yznXHRjZtOd5ec1Xwswz+o65IIgK3WcLdAPZ5+dTlBTInZBmKJpBQcnoZmscq0m2EC
         +yjlXibpXDCcRxQx/MK1XxLGx1AvINalw4UCQg3/MOi2gnEu8tNqwH+hn6MOtnVADU
         2LJhn8uUhn4rtONYyGtAgz0FRO8AyTioyQSukYFYgR7OPz7WTnMiDcwWDWosxOPLqQ
         bAKZBxwGeV0Aw==
Message-ID: <b16636bf-38c5-93eb-0dea-7ded14bf241a@kernel.org>
Date:   Mon, 16 Oct 2023 11:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: Clean up errors in segment.h
Content-Language: en-US
To:     KaiLong Wang <wangkailong@jari.cn>, jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
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

On 2023/10/13 14:45, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
