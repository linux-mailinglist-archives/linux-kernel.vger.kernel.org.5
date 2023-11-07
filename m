Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCD7E38DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjKGKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjKGKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:20:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B8B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:20:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1762FC433C7;
        Tue,  7 Nov 2023 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699352449;
        bh=0m38NUeLOMHtl8nIK5Oyv/8a4A8+60kkJeGGDn+94Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikwAnVEWM/HHqsj459F5JhhB7JP4ImUGuXoXvjFYvNIymldBGWla0G7mhYSH/s3UD
         ROvTT4kI/Fa6mcbn2Xn5BbmBU98CmExlkYZ0PTQL/b7Ws5AU/SQbBXjQafJjtpgp7k
         lNkYIFyiOoY/rG0gZi4SaKH2f9/mdjQyBcfZIkGsz9dvi44O+ciNJgqR5/LtftL0W3
         P9IUfrHouKtnCVLsmvRCTTyTtfqKTsDn2lk945SU5lKWbbO+DwKmzgyLO55NkK5tKO
         j3k12oqclPWuE13kng/nQWiVwv2vHkD60COLyZ9PkWF4hJIHYPbeGapX+UTaQkFeaE
         UW7vqMECFk7/g==
Date:   Tue, 7 Nov 2023 10:20:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Marielle Novastrider <marielle@novastrider.com>
Cc:     linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/arm64: Fix typos in elf_hwcaps
Message-ID: <20231107102044.GD18944@willie-the-truck>
References: <20231031200838.55569-1-marielle@novastrider.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031200838.55569-1-marielle@novastrider.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 08:08:38PM +0000, Marielle Novastrider wrote:
> Small typos in register and field names.
> 
> Signed-off-by: Marielle Novastrider <marielle@novastrider.com>
> ---
>  Documentation/arch/arm64/elf_hwcaps.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
