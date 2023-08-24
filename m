Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028BF786EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbjHXMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbjHXMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EF198B;
        Thu, 24 Aug 2023 05:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0916E6182F;
        Thu, 24 Aug 2023 12:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2091EC433C7;
        Thu, 24 Aug 2023 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692878499;
        bh=bJY9G1iFXdRtnbG9KMtyME+7lESXhupRpB5L5sFYIcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvzeQveNVO/Kpi/8aK2eol92jbHsdRiL4Nz5AsdYc4vydGd8oWj8FiUtWPZi4useN
         Hjon0hVwcf2iZ/OKBV+0+/qCvm5OHubsENVjtGUv3OWIhJcgO8Hv+lllOPmH6tDWXg
         ZNFQyEJ3pJbmyWUD63NfiRIuxrDO0F+rZJ2X3xKI=
Date:   Thu, 24 Aug 2023 14:00:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.6
Message-ID: <2023082449-perish-padded-cd05@gregkh>
References: <20230824094633.866043-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824094633.866043-1-djakov@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:46:33PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect updates for the 6.6-rc1 merge
> window. In contains a mix of core and driver changes as usual. This time
> it might look a bit bigger as lines of code, but 97.5% of these are related
> to expanding some macros in drivers and bring no functional change. There
> are also a few patches that touch qcom clock drivers and these are in
> immutable branch that is pulled also by the qcom tree. It contains also a
> debugfs patch that you acked recently. The complete summary and details
> are in the signed tag.
> 
> All patches have been in linux-next during last few days. Please pull into
> char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:
> 
>   Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.6-rc1

Now pulled and pushed out, thanks.

greg k-h
