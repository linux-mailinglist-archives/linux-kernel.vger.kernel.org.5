Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3247F3FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjKVIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjKVIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:17:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BFA4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:17:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7E0C433C7;
        Wed, 22 Nov 2023 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700641054;
        bh=t/49KUB9MGEsCs1/F2RgCFFrkf6Q4Z0X9hderngc+dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmPcxdgQdYDZ8WmevM6jFWzkSDozri7uLw2yfDDYFOFUPxH1ucRTo9gh3YfWKH+pN
         Dq2U/sYxIIathvFknmrM5Pe8hrWf/23nTlR9aeIYYwckMkxR2m61bmOX1xp22xPoeM
         gI6Iv4C/Wf0T3vOaL230HNd3pF9CdyE+3GDIqVsumkoPvFiukM4JNk+xq4PiwXuz50
         oeI/fPjS1pipQCEWZJo2azse4dDWzYDlyQdxUblA1iuPkVQ6NZ05+Ep3ndBKZrE8MJ
         R7U3iz0vOw5v3JdTBR2L/cZhE0KZpe3Hw49F2kyfoot0YN2lRAhGpNqF92tv+Di3RF
         6Bn7Gggjw4Hfg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5iQe-0005tx-1M;
        Wed, 22 Nov 2023 09:17:48 +0100
Date:   Wed, 22 Nov 2023 09:17:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Victor Fragoso <victorffs@hotmail.com>,
        Lars Melin <larsm17@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] USB: serial: option: add Fibocom L7xx modules
Message-ID: <ZV25LMQmNjBeucH2@hovoldconsulting.com>
References: <39dd187fe27244f28fa729ce134d9d130147f2e1.camel@hotmail.com>
 <77b61923-b0df-4120-be19-4442e84fa118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b61923-b0df-4120-be19-4442e84fa118@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:48:43AM +0700, Lars Melin wrote:
> On 11/22/2023 4:05, Victor Fragoso wrote:
> > Add support for Fibocom L716-EU module series.

> > Changes since v1:
> >   - Removed non-essential VID/PID to work with L716-EU tested module.
> >   - Added device entry comment according to tested module/modes.
> >   - Added according to VID/PID order
> >   - Commit message improved with more information about module ports.

> thanks, looks much better now
> 
> Reviewed-by: Lars Melin <larsm17@gmail.com>

Thanks for the update and for the review. Now applied.

Johan
