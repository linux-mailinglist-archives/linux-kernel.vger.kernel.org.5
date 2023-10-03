Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65537B6218
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbjJCHFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjJCHFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:05:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2F90
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:05:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6FCC433C7;
        Tue,  3 Oct 2023 07:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696316736;
        bh=SjGX3jCFVdiNsB2r2BY7I5WgDYwtsa92FOhazxUr+iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5RDnAoElwAkbKO9DyhYFDDRq/2FQ/6FvrGCb3609E2bA5ZZImlL7nuowYdxArol4
         KiBG+BjZfxOa3JiS0vsz2+2B6w41FJMNsuLddxIFrZdRPdaFrlgMiXeZ1A8pvVSzYQ
         PRSHteEYXDYP46qFLi7KbYhzvJYtX11EKOdevqHc=
Date:   Tue, 3 Oct 2023 09:05:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     peter.chen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Message-ID: <2023100342-unnerving-diaphragm-cf36@gregkh>
References: <20231002161350.64229-1-tmaimon77@gmail.com>
 <2023100323-reunite-upfront-8922@gregkh>
 <CAP6Zq1jHzRP1Ytzk8YXyR8ppAP=ZoPvPkYvC2yMRfTt5140zqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1jHzRP1Ytzk8YXyR8ppAP=ZoPvPkYvC2yMRfTt5140zqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:56:47AM +0300, Tomer Maimon wrote:
> Hi Greg,
> 
> Forgot to add in Acked-by: Peter Chen <peter.chen@kernel.org> in V3,
> Resend the patch set with the Ack.
> 
> Should I do it differently?

You need to tell me what the difference is, otherwise I would have no
clue what to do, what would you do if you had to review all of these and
try to figure out which ones to accept?

Please send this as a v4.

thanks,

greg k-h
