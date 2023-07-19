Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93C75907E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGSInL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGSInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC510E;
        Wed, 19 Jul 2023 01:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B850D611F6;
        Wed, 19 Jul 2023 08:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B131C433C7;
        Wed, 19 Jul 2023 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689756188;
        bh=Tcgl5s4cZM1kHLfv+uFWn6PeSJf00yr1+HIpYcCHIzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTnxBfMxHjGtuWMLt/niyHetNTb/m6WO1yGvd8eitP/gjLwWKuDk7Xx3ztNXfz+C0
         ebwbuwNEXcIgyxiuRRZFvb+LPfgYDBNcmXRAmpbYPw0PnHWLUC258PJrcH4+86WPS2
         CFqrSGi7+aA2D2HSUdeiVgbfQWbxrGWMJYSrGzdPIGLtIzq/9lqe3CeDVDZ2Hf+haR
         +mIa4vARb7a4mtaQy7FpJCb4XPVJJNSDdpiFMtC/HcGi2gvimLeebwpazOAQCUSJN0
         MeORfNkUXDALkqFVgWKfY0TF9KRImRzUN33q53tZ0phdeBbSJoJrM+uk3PsQCl6wp9
         eawX0z4wLZstQ==
Date:   Wed, 19 Jul 2023 09:43:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds: default config switch to
 platform switch
Message-ID: <20230719084301.GG1082701@google.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-3-henning.schild@siemens.com>
 <ZLaf0Cn2kfb0qxJJ@smile.fi.intel.com>
 <20230718164308.6b7d875a@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718164308.6b7d875a@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, Henning Schild wrote:

> Am Tue, 18 Jul 2023 17:21:04 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> > On Tue, Jul 18, 2023 at 12:52:12PM +0200, Henning Schild wrote:
> > > If a user did choose to enable Siemens Simatic platform support they
> > > likely want the LED drivers to be enabled without having to flip
> > > more config switches. So we make the LED drivers config switch
> > > default to the platform driver switches value.  
> > 
> > Same as per previous patch.
> > 
> 
> Same as per previous patch.

Same as per previous patch.

-- 
Lee Jones [李琼斯]
