Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AC17BD1D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjJICAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJICAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:00:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079DFA4;
        Sun,  8 Oct 2023 19:00:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03266C433C8;
        Mon,  9 Oct 2023 02:00:07 +0000 (UTC)
Message-ID: <f0d0e8ad-8391-44f3-90e0-d2325daebb64@linux-m68k.org>
Date:   Mon, 9 Oct 2023 12:00:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the m68knommu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231009111609.13ac1edb@canb.auug.org.au>
Content-Language: en-US
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20231009111609.13ac1edb@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 9/10/23 10:16, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the m68k tree as a different commit
> (but the same patch):
> 
>    af580d01acc3 ("m68k: use kernel's generic libgcc functions")
> 
> The is commit
> 
>    a0938a8e2fb3 ("m68k: Use kernel's generic libgcc functions")
> 
> in the m68k tree.

Sorry, yes, fixed now. I removed it from the m68kmnommu git tree.

Regards
Greg


