Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EA75C609
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGULqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGULqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739691FD7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0515661934
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40533C433C7;
        Fri, 21 Jul 2023 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689939962;
        bh=qDyDEJ4W0VMd/W7yiNxx/xTfgRtOvwlg15PRBJjEXBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVRPhCQswMvWu7Nj560fH9gbh1QsnUYO9MxkdD4sTGsT75wklNueu0AYV1CSrUSP9
         jNT4kD5HQenEyBErffFdlBacQwWZfyu90tvayiPk7b0ZYmO4ymPwINOarOwoKN4Xg5
         07UAaDxlewNYAV9VTggnZfxBZvT5FOwedUxIpuM+Dit7As6qETrwjI9ZPYCgVGoWVn
         UzO3HIDxpGtH6dr1EFapjVXjlvoJi7A7xnV7nvmKOa8yyJVusB6sL/Wa4cKAYZ2bB7
         KXDuFmTazLvWcEDo0P0zu5jfjIWZgzJi85KxPqdX8rNboTL8/u8FMFn3VklvgZ3c6c
         ExDNKXUotz9QA==
Date:   Fri, 21 Jul 2023 12:45:57 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20230721114557.GB12852@willie-the-truck>
References: <20230721114423.GA12852@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721114423.GA12852@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:44:23PM +0100, Will Deacon wrote:
> Please pull.

Duh, $subject should've been "6.5-rc3" not "-rc5", so please don't wait
that long!

Will
