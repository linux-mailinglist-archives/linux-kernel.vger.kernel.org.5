Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFAB7CB323
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjJPTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:06:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33895
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697483199;
        bh=fNlg5y62WcNfr15jySJT29QgSFcJIWbexiG2Rqkr/ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNTOxDwvpGeUGDDBAKOM4sS4vIfvjw7U9UTG5U3Pb37WgMH96kWPt0McQ2VRJGBDH
         KIhgzsSTlrgOlgwqO9/BJoR+sFkkbmH+bbtnpa8SZqsZNp6KCVZBy7N36cXBqrYW5O
         WCualWVWwxdcSIn0m8j+kjknpS0YE5DEHc1z/nGw=
Date:   Mon, 16 Oct 2023 21:06:39 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: patch "misc/pvpanic: deduplicate comomn code" added to
 char-misc-testing
Message-ID: <19f56fba-7ed5-4bc3-9ba5-37f4ab6e1857@t-8ch.de>
References: <2023101657-charcoal-snowy-21be@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101657-charcoal-snowy-21be@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2023-10-16 20:57:57+0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     misc/pvpanic: deduplicate comomn code

It seems I managed to inject a typo into the commit subject:

s/comomn/common/

In case it's still possible and worth it, could you fix it up?

> to my char-misc git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> in the char-misc-testing branch.
> 
> The patch will show up in the next release of the linux-next tree
> (usually sometime within the next 24 hours during the week.)
> 
> The patch will be merged to the char-misc-next branch sometime soon,
> after it passes testing, and the merge window is open.
> 
> If you have any questions about this process, please let me know.

Thanks,
Thomas
