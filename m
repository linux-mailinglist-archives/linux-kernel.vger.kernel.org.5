Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E657C7D9B68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjJ0O3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbjJ0O3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:29:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44554C4;
        Fri, 27 Oct 2023 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=G3hIZfT/tWTk0hSzDgX6jOfa4f24uiv1v7ar0PbjQbI=; b=UREwDYeceNZN2uZb9VxTdHn2kb
        mEkBqRdKBqJbDYjVl80gppT10PmC7OFTWJXqEfC7AasypF98S7U533l475vwxXKI9nGWCz3p0pQ+r
        ryCVtydjWgOe/R37NNey7Amjjc9tLvuXHmFMr/pFaDjgk0aB2pa1iaf8alM41qAk0lKU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qwNqI-000LVH-2h; Fri, 27 Oct 2023 16:29:42 +0200
Date:   Fri, 27 Oct 2023 16:29:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        pali@kernel.org, mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cyuval@marvell.com
Subject: Re: [PATCH v3 2/3] dt-bindings: arm64: dts: add dt-bindings for ac5x
 rd carrier
Message-ID: <4bb9b888-b51e-4177-965b-bf301962f6fc@lunn.ch>
References: <20231026084735.3595944-1-enachman@marvell.com>
 <20231026084735.3595944-3-enachman@marvell.com>
 <1075eedc-3e7e-4070-8cf2-ae63513fd764@linaro.org>
 <20231027-opposite-frostily-b41eb861c8a1@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-opposite-frostily-b41eb861c8a1@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > No underscores in compatibles.
> 
> Oh shit, I didn't notice that somehow. Un-acked until that's removed.

Not a problem. Its way too late for this merge window. The pull
request for Marvell stuff has already been sent to arm-soc. There is
plenty of time to fix this, and there are other problems to address as
well.

	Andrew
