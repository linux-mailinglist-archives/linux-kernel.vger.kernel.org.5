Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0E7D2AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjJWHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjJWHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:12:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E4D5B;
        Mon, 23 Oct 2023 00:12:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0A3D51C0050; Mon, 23 Oct 2023 09:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1698045163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWY9IhwyIhCeVdCcLJwPKSHJpNtnV6qmnh4HjGO9q7s=;
        b=nIRJ+lnGZh4xqfEGSQoJhUb5cpx+RBavjKyF3CYORizYMoQXK0RsgXM3qMKhfbZn9daw+1
        B9nMOzlZQ4XDA33mXpM93Cf/k0/IAuhv2CWpfYLzKgAD/GeUXQXbokSXiBG7Bp/CjNJqvR
        +6zuRJODzNzADmwRhy122wHuWjWRj6k=
Date:   Mon, 23 Oct 2023 09:12:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <ZTYc6l2ZpLeGRFj9@duo.ucw.cz>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
 <20231011222026.4181654-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231011222026.4181654-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-11 15:20:25, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.

Note that by making it more "inclusive" you make it incomprehensible
for users where english is not their first language.

Plus, "user" already means something else in kernel context, so this
will likely be confusing even for native speakers.

This is wrong.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.
