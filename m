Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4D78575A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjHWMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjHWMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F0E65
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cX6ylMz4wxW;
        Wed, 23 Aug 2023 22:03:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Message-Id: <169279175561.797584.8650753652386508689.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:19:18 +0200, Arnd Bergmann wrote:
> Most of the patches I sent so far for the -Wmissing-prototype warnings
> have made it into linux-next now. There are a few that I'm resending
> now as nobody has picked them up, and then a number of fixes that I
> found while test-building across all architectures rather than just the
> ones I usually test.
> 
> The first 15 patches in this series should be uncontroversial, so
> I expect that either a subsystem maintainer or Andrew Morton can
> apply these directly.
> 
> [...]

Applied to powerpc/next.

[06/17] macintosh/ams: mark ams_init() static
        https://git.kernel.org/powerpc/c/cd50430ceb3598957803934068531a274349bcf9

cheers
