Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BEC785AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjHWOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjHWOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5718410FA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D84D6663DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F69CC433C7;
        Wed, 23 Aug 2023 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692801515;
        bh=MiK73TZc2KpjLlp7+OAj1DW1O0IWdMemFhSZ6Aa9Y4s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lSMwIz2wlIZc1l5HdvhFFl29xh6p9Duggjx+3IeADNpwisPwCa/L4bWm7WSpdRAih
         EQb5nIRgiQdzNCa3ICqzhXOXKWMTIQV8xhrvbmar6f8SQqHqG81eY9QYWz4D3/17cn
         OrUpCeX3G3m26Xm9CTxxFtN1Igfg23kRXZoqxq9N0dQopCzu9C+NRxLGVldHLlsziL
         gMoAtwpWHySF87iUDJjoWkVamqlw8vuCR9t3SDdMHqsKuelwnODQsiBxiNN4oy232L
         S/rFq1guO6AnpHgtAHH+ybx8WMRvd274Hj9vewpq/gu6U4hRhTgX5mGzpLpBgmhzE9
         bErjPlSxEXa1g==
Message-ID: <7434f8ce-6684-c520-b3f6-d85326a01dca@kernel.org>
Date:   Wed, 23 Aug 2023 22:38:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] erofs: clean up redundant comment and adjust code
 alignment
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230815094849.53249-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 17:48, Ferry Meng wrote:
> Remove some redundant comments in erofs/super.c, and avoid unncessary
> line breaks for cleanup.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
