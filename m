Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B3792789
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbjIEQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353517AbjIEG2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:28:21 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB0D4CC4;
        Mon,  4 Sep 2023 23:28:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 46DA780A3;
        Tue,  5 Sep 2023 06:28:17 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:28:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add TI TWL603X GPADC
Message-ID: <20230905062815.GY11676@atomide.com>
References: <20230816202614.324457-1-andreas@kemnade.info>
 <426d78d6-9fa6-bfeb-b36a-fba264097a27@linaro.org>
 <20230819221903.726a1c39@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819221903.726a1c39@aktux>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230820 00:11]:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > On 16/08/2023 22:26, Andreas Kemnade wrote:
> > > +title: GPADC subsystem in the TWL6030 power module
> > > +
> > > +maintainers:
> > > +  - Jonathan Cameron <jic23@kernel.org>  
> > 
> > This should be rather someone knowing or having or caring about this
> > particular hardware, not subsystem maintainer.
> > 
> Hmm, I have the twl6032, but not the twl6030. So probably
> Tony (OMAP-Maintainer) or me?

Please add yourself :)

Regards,

Tony
