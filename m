Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E07ABA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjIVTw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIVTw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBD19D;
        Fri, 22 Sep 2023 12:52:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FEFC433C7;
        Fri, 22 Sep 2023 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695412341;
        bh=imeUxCVuAEVLFhiNc4IeK3wuYja4OS++9ONx3qO3WBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SqyOWOQh8dbD5rhF2gxDSXIeno3Mg5ZFM72XR/4d1SaWKwtLyZsBR9+eO1+Av9jJx
         jRpzSkDsh4i15+Ud5c18MK9Bs2P1nspOfMEcWm3873/A0CjRA3dRRbHmPWJ4fveKs0
         Mx1D8orr8GOf8XoJiwfqVlsCFTzmZsdNsRZjK3lLg+q+7kt+Iy0+JA7FTtYIAli527
         onmF8bFYSQI2/oCGNZXHS1cldv3vGUPV3iDc6/hBSZpTloH5IizTFZV4ppW/nyVaWx
         nVBuT2nGb9gscPqd//EC1qv0AvTmPly1OmSTVHp5/vEC0KyF1YALeU8jj5svzDyoln
         qfXUMXsnIqF4g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50435ad51bbso2554419e87.2;
        Fri, 22 Sep 2023 12:52:20 -0700 (PDT)
X-Gm-Message-State: AOJu0Yya//mvfQtynf0HrKJBmEggrXZULqAb4udBKonJsq6FRSzA3ZV+
        23406mXVfdRxsZWpSVzyzRKfBlQLRwsAHrjiTA==
X-Google-Smtp-Source: AGHT+IEjbFWOc2dJSZl+LGspXeTZskF2ku6FT/4P4ACzKx2mojBSEIPlpHP7hQaNPypseQNqhkbrOaUGGWgshym7TGQ=
X-Received: by 2002:a05:6512:23a5:b0:502:c615:99a9 with SMTP id
 c37-20020a05651223a500b00502c61599a9mr572466lfv.30.1695412339219; Fri, 22 Sep
 2023 12:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230920152015.1376838-1-hugo@hugovil.com> <20230920152015.1376838-4-hugo@hugovil.com>
 <20230921162424.GA435508-robh@kernel.org> <20230921123237.b3c50eb12746724a4fd62237@hugovil.com>
In-Reply-To: <20230921123237.b3c50eb12746724a4fd62237@hugovil.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Sep 2023 14:52:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLpJuxJ1ZbMkwXPrzUAK3Xhfr4zFgSYvmFufyDRF1QjpQ@mail.gmail.com>
Message-ID: <CAL_JsqLpJuxJ1ZbMkwXPrzUAK3Xhfr4zFgSYvmFufyDRF1QjpQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to
 irda-mode-ports property
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:32=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> On Thu, 21 Sep 2023 11:24:24 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, Sep 20, 2023 at 11:20:14AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > The NXP-specific "irda-mode-ports" property lacks a proper vendor
> > > prefix. Add "nxp," prefix to comply with DT best practises.
> >
> > The opposite direction would be worth carrying in the driver, but I
> > don't think adding a vendor prefix is. I would just leave this as-is.
> >
> > Rob
>
> Hi Rob,
> I am not following you, can you clarify?

Just keep the property as-is and don't add a 'nxp,' prefixed version.
It's not worth carrying the fallback in the driver.

If you were dropping a vendor prefix from a property, then that's
worth it because there might be other users added.

Rob
