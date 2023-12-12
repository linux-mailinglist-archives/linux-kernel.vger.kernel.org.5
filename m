Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39B680E67E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjLLIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjLLIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:43:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FB6106
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:43:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AB6C433C8;
        Tue, 12 Dec 2023 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702370639;
        bh=+udAdbv74ZH3Ec7v7gNkzkQW186AgEuuT/4lHWXQJa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAfNCedXuKTLRzZikctAa8tYeRcWK6eynmGaRAikE32izQQ+ukuhOZQZnA3Cy6fC/
         krlmBjTF1Map9k4RMbGSTfch58p7I5M9bWZU1BmFkKeIjKRHBY9lm9PqNrkp4ovVW0
         bl9ZwJtMYghgCMPInSfpZ+nj7bDbc3sKOnzR6a5U=
Date:   Tue, 12 Dec 2023 09:43:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.7-rc
Message-ID: <2023121235-amplifier-percolate-f23c@gregkh>
References: <20231209101548.1240700-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209101548.1240700-1-djakov@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 12:15:48PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a few tiny fixes for the current cycle. The
> details are in the signed tag. All patches have been in linux-next
> during the last few days. Please pull into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.7-rc5

Pulled and pushed out, thanks.

greg k-h
