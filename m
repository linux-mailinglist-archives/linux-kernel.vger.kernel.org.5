Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69CE7BF98F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjJJLVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJJLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:21:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BCC9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:21:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309C1C433C7;
        Tue, 10 Oct 2023 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696936905;
        bh=mf4hrEAKdYA8Nksyobd+OEdeGNe+2vf/Db/OEH+EnIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lILMasczVih2HWAvVG5erexx8W3MqqGkZkb+Bs2ca1rHfO/n/K4bgAhuirSrK9oo8
         Xc0fL4sm0sQEIVL7++JmbyLdJ6Vx69TmIm5204Jd2lPoWeZ8xF+uzrrQ9iSkJnHr6j
         DlUHj4g+7pZ3I940NKlJb7EeU05l9gaaiC2U/WZc=
Date:   Tue, 10 Oct 2023 13:21:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 00/14] Add TPS25750 USB type-C PD controller support
Message-ID: <2023101025-murmuring-dorsal-781f@gregkh>
References: <20231003155842.57313-1-alkuor@gmail.com>
 <2023101017-custard-scale-470f@gregkh>
 <ZSUw4kDgzAIR/F3m@primary>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUw4kDgzAIR/F3m@primary>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:09:22AM -0400, Abdel Alkuor wrote:
> On Tue, Oct 10, 2023 at 09:02:55AM +0200, Greg KH wrote:
> > On Tue, Oct 03, 2023 at 11:58:33AM -0400, Abdel Alkuor wrote:
> > > From: Abdel Alkuor <abdelalkuor@geotab.com>
> >
> Hi Greg,
> > Note, your subject line says 00/14 yet your patches had 00/09.  I hope
> > you didn't dropp patches somewhere?
> >
> Sorry, it is just a copy/paste error from v9 as v9 has 14 patches.
> > I applied what is here now, but are some missing?
> >
> No, they are 9 patches in v10 as many patches from v9 got merged into
> one patch. Should I upload another cover letter to fix the subject line?

No, that would just confuse me more, all is good now, thanks.

greg k-h
