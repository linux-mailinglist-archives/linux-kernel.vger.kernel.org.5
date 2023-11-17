Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AE27EFB54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbjKQWX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:23:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7524D4D;
        Fri, 17 Nov 2023 14:23:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17850C433C7;
        Fri, 17 Nov 2023 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259805;
        bh=6DSf0nVAntIkLaU9iNZUmUavKWJVfxe1caFDUs65/3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixZzA2X26bUECEOcgxtNg2do6HNVXqKNT//yk0SBxN3MgFT5jEDTCdbaOFSWpojTg
         VsK6GvtACJIGGBATK5YX5gsghJC7DG842otaPfUiNEP0/8hFPoRB5aKRXAEjzEIpFV
         rNLIh7MNDaJtm87W0pBJ/Mj1xygY8yvnzVEMuU48Zvj8M/ozmvNEn+Zwy/Ey3HZ32R
         ZeSrzn8+nyjG0uA35Cj293gtQkjs/aE0TCpFHllAUfOl+bLgIcB1VbTggElLeB+4ks
         IBsaePJzYSQX3rGo4vSHUyYA9+HniIM9aQNJqOhWHb9KPE5mk8dLG1QiO5pytTbmDo
         mMKNUeyIsvbrA==
Date:   Fri, 17 Nov 2023 14:23:24 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add netdev subsystem profile link
Message-ID: <20231117142324.522fb816@kernel.org>
In-Reply-To: <20231116201147.work.668-kees@kernel.org>
References: <20231116201147.work.668-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 12:11:51 -0800 Kees Cook wrote:
> The netdev subsystem has had a subsystem process document for a while now.

I wasn't sure if it's technically a profile or not.

Let me widen the CC a bit and see if someone can tell us one way 
or the other. Our process doc is not listed in
Documentation/maintainer/maintainer-entry-profile.rst either.
Perhaps it's good enough for P: but not for linking there.
