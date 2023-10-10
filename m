Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A297BFB34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjJJMVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJJMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:21:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D77AC;
        Tue, 10 Oct 2023 05:21:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C652C433C8;
        Tue, 10 Oct 2023 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696940499;
        bh=MXtBDS8DsESDRSFcfb9fET6a/Rx+2lbVE19xsUW6l00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8q9uKv8jPAvcgF3wYpIIW/IJSugKRAoc6f8CERfo49CvRLrolKdSoFgMdcwrdl1z
         wxwhJCBlQsvYDhlheGi0q9KcxnE6aFHMhqpTk5seITkBQZPHckzw9prQV5xwrjzOqf
         HMbgjI/aEfhih2d3Dasm32cZM4JbkQF9q261fLKU=
Date:   Tue, 10 Oct 2023 14:21:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux@roeck-us.net, joe@perches.com,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/process/coding-style.rst: space around
 const/volatile
Message-ID: <2023101025-senorita-boxlike-09a5@gregkh>
References: <20231010101240.992984-1-max.kellermann@ionos.com>
 <2023101025-bungee-carve-2b4b@gregkh>
 <CAKPOu+_x=C=1kpU_j0HoVn=o3PxRk=PH7a6YPeW8du_sQxJMYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_x=C=1kpU_j0HoVn=o3PxRk=PH7a6YPeW8du_sQxJMYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:03:25PM +0200, Max Kellermann wrote:
> On Tue, Oct 10, 2023 at 1:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > Don't encourage the use of volatile please
> 
> I don't mean to - but I figured IF "volatile" is used (for whatever
> reason, whether correct or not), it should follow the same coding
> style as "const".
> 
> Do you want me to remove mentions of "volatile" (leaving the coding
> style unspecified), or do you want me to add some warning about using
> volatile?

I would recommend just removing the mentions of it here.

thanks,

greg k-h
