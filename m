Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63907B707B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbjJCSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJCSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:03:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E48E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:03:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295A0C433C8;
        Tue,  3 Oct 2023 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696356205;
        bh=tdp1GQLnOzhP5N7sgd2m46EkMMOgLP/jZDUmpIqE9lQ=;
        h=Date:From:To:Subject:From;
        b=MuLH8vYRqHnUtn/2KYBMAyLizj37JzEA4/EU+xaVXFN2DJBKGAM/e8wgzNxF62WpW
         aES6wVtuEG6pMWeauClY+vi5g2UcxcnyL8B3KkBOsZVkVZey1aDBoAX6ZZfMRs1/4M
         +qPN32Ahud1BX1T3TaQ1OpJcfvR2pjiTnrI6WNDLTB8YrQKXEUJqx1mqCxItLw8NC/
         7tlC9W+NEA+hhTpEimkpBEPq17I/I61NW9u737yvCwi1dONGn6IYrNA/nUthqILIuf
         LzjoKC6WYyeNWonFIsHtRD9+0sEAm9ulCArL6xxY2lbfuFfKmrGxv8UToSeeOCLXA+
         pthNVr7JdOfww==
Date:   Tue, 3 Oct 2023 11:03:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 17.0.2 uploaded
Message-ID: <20231003180323.GA419007@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 17.0.2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via
email or https://github.com/ClangBuiltLinux/linux/issues/new, so that we
have an opportunity to get them fixed in main and backported before the
17.x series is no longer supported.

Cheers,
Nathan
