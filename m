Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFB7FEE91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjK3MGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbjK3MFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:05:49 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86D10FF;
        Thu, 30 Nov 2023 04:05:55 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id C0C3B60513;
        Thu, 30 Nov 2023 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701345954;
        bh=64j2ievVtQY927UUjwWzElwnhla7pdOyy4BEKWcOMUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjUVaZQwu5nwPYHMTyThDrx+JB04YB91pHg6wpWf/HpaIoOSUdRFjGmci4jYiWlTC
         eoIeXAMBN8HZvXqUNDqIORpTwmAUXqSXenV70SdCRRqCV1Lxpr6chRqctiH+nH7kY6
         fcdCZoSeELD/Rd9LfnZgzD+WcS0cjLBYpeDVUu+/uvCUvcx+qj75Fdr6ADE1xB/PVz
         bkWBGNXkoVS678+PUZG0rmeQjtYfsYaHRdn1olC0671fw5TfJar+imqWTOaZSyBw6E
         0zHN5zEDFxSPU30QzjyhK8g+Xires0UTQ2fPE/2aauStsdhwYdZDfM0+pgGaxfaKFD
         FYiZrtkoXSIEw==
Date:   Thu, 30 Nov 2023 14:05:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap: logicpd-torpedo: do not disguise GNSS
 device
Message-ID: <20231130120533.GD5169@atomide.com>
References: <20231127200430.143231-1-andreas@kemnade.info>
 <CAHCN7xLpERbs1MPMXTAPCqoPgAN5ts+Ubr=MiO6urW-wuuxp=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLpERbs1MPMXTAPCqoPgAN5ts+Ubr=MiO6urW-wuuxp=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [231127 20:40]:
> On Mon, Nov 27, 2023 at 2:04 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > https://support.logicpd.com/DesktopModules/Bring2mind/DMX/Download.aspx?portalid=0&EntryId=649
> > clearly specifies the availability of GPS, so let's not disguise it
> > and name the node accordingly.
> 
> Thanks for doing this.

Applying into omap-for-v6.8/dt thanks.

Tony
