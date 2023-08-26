Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570AA7893B0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHZDc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjHZDb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:31:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550952726;
        Fri, 25 Aug 2023 20:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=72kK5Ep1kkA5knkUNVThYA+0bEjS3EOGvxVBQuwd670=; b=OU+zJrNG5omv4nZFcURkhkf9EO
        pRqb+ljiUDecfhtp1cHEGanpTALH/vHmoxpR8sTLUPcFk2Y3K3loweB1G9H6Y+YIvsTjF26vBp2et
        +oBYio71lfEs/rD68xM41NNA5swNuqgG+CeKhDTGuVwl09FdTuLc0yKQub76yd53bNa8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qZk17-0058sN-7C; Sat, 26 Aug 2023 05:31:17 +0200
Date:   Sat, 26 Aug 2023 05:31:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm: marvell: Fix maxium->maxim typo for
 brownstone dts
Message-ID: <4a3aabf1-984b-4f96-ad22-2a22281a1260@lunn.ch>
References: <20230821-brownstone-typo-fix-v1-1-277983372d3a@skole.hr>
 <7336acfc-eea8-472c-8b04-c04b4c401fe8@lunn.ch>
 <4825493.GXAFRqVoOG@radijator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4825493.GXAFRqVoOG@radijator>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume this PMIC would behave identically and thus this should go to stable. 
> Would this be done by sending a v2 with the Cc: tag added?

Thanks for testing this.  Please also add a Fixes: tag, probably for
when the node was added to DT.

     Andrew
