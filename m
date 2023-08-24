Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC99787B43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbjHXWMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbjHXWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:11:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7424B1B9;
        Thu, 24 Aug 2023 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=IULd71hYTp7SSCpHE69doNZADNArdGVLLy2/vmohNy0=; b=IAkkTSMedXEv6I+ai/YoK06wGd
        ydp8ICWf8C/M9v2l815aLY7c/RlmQA60XfjhdMLBQ+MPIRvSj9GZ4QEi90q+KA3Ap4Joq9Js7E9vv
        zQ/att4GWNK+I8PX3ZnD+3KU5CtZdAwmoK5Y3mgCVkOEJ44kmgvMD3h0w6LvzTZmVrU0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qZIY2-005246-8L; Fri, 25 Aug 2023 00:11:26 +0200
Date:   Fri, 25 Aug 2023 00:11:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     airat.gl@gmail.com
Cc:     alexis.lothore@bootlin.com, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        olteanv@gmail.com, pabeni@redhat.com, paul.arola@telus.com,
        richardcochran@gmail.com, scott.roberts@telus.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: marvell: add
 MV88E6361 switch to compatibility list
Message-ID: <f587e834-3e71-4f1e-baa0-925ab1b74c77@lunn.ch>
References: <20230517203430.448705-2-alexis.lothore@bootlin.com>
 <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:49:17PM +0200, airat.gl@gmail.com wrote:
> Is there an error? The new string include 6163 instead of 6361

You need to provide some context here. Maybe the git hash of the
patch? Or a chunk of code.

	Andrew
