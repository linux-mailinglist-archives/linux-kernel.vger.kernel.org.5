Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E27791F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbjIDWgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbjIDWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05221EA;
        Mon,  4 Sep 2023 15:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983E2617A3;
        Mon,  4 Sep 2023 22:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F79DC433C9;
        Mon,  4 Sep 2023 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693866971;
        bh=S+H92h7zdbldeffBUDQRIOrBGcPtQovCu106jpRm97M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+KtOSR5xfT0PGLaW1D3Q2Qxr5ViJItsA5nWIi93QbjyTpRjeDYqrHEvT4VDuMr9z
         asf51ntt1nzqE0gOG3aq9WRGKARxYGqwDCxQd0fVD8cklhE8KB6spIJMAjJ5ZeRQlN
         xbaP9kZ4Vc/2RwonoS0id9+33p5kehqiOowln0KNJDx+WBgJhq7xpcmmqubAtr5zOV
         sQzUp3KNfwU8a7CcElF6CxzpJHxKlRaAUAkUrAB4lRSeG5rZ7Nx0KgC/XmVu8Zjzts
         vFNuJK+DvY4mN7u7VJRta+W4puYgArmzdOY7NnlvRdA2cvf/2ZPLXPHwlDXU3amOmh
         5NWeJrttL1PjA==
Date:   Tue, 5 Sep 2023 07:36:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the ftrace tree
Message-Id: <20230905073605.fc7575158f3198a1a50713e0@kernel.org>
In-Reply-To: <20230905075033.0df2b7fa@canb.auug.org.au>
References: <20230905075033.0df2b7fa@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 07:50:33 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   bd96000ba862 ("Documentation: tracing: Update fprobe event example with BTF field")

Hmm, this is included in my topic branch. Anyway, let me rebase it on linus tree.

Thank you!

> 
> This is commit
> 
>   a2439a4c9085 ("Documentation: tracing: Update fprobe event example with BTF field")
> 
> in Linus' tree.
> 
> -- 
> Cheers,
> Stephen Rothwell


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
