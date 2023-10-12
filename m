Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650BD7C716B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379403AbjJLP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379229AbjJLP2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:28:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A5C0;
        Thu, 12 Oct 2023 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Y3vhvxIcoWBz8+4W1+pMn0rc7jF/ULpbocNtPW87JTA=;
        t=1697124521; x=1698334121; b=QpiDtsefBGwabxn48wW/rXPtvsi2bLnD9uw7RAfrZVwoXv8
        6jrf1Gx290FCilr3kG8s9cY9/QMESQEEsuOCA6NwiC6yg6tEGGujLde6Dw1efGHaUSPGFalOR3CME
        hHkhrpF74jjRFXV0K0f/7IytvDPchJtjy80mGFbY/VhZhXUAKaOWFi1GuaLfoX0FHefxJ/5yaGwAq
        ohj3tLpdIsdh3qwARE02xdFUghMirAtq9ywfEYFe/HlxqQZjtzX3lSQyLfGu/Z/ut6usxeHzLyjSF
        vYUbk93ICQphgSfTIXVw4HjzLw8S+qLLEKIbiTOAwdCs/LB4q24wFQRE0+zndJsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqxby-00000003SHc-0xxw;
        Thu, 12 Oct 2023 17:28:30 +0200
Message-ID: <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, Geoff Levand <geoff@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Thu, 12 Oct 2023 17:28:28 +0200
In-Reply-To: <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
References: <20231010155444.858483-1-arnd@kernel.org>
         <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
         <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
         <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
         <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 16:36 +0200, Arnd Bergmann wrote:
>=20
> ps3-gelic-wireless

Didn't Sony disable Linux on PS3 eventually? Though maybe someone still
has some devices with old software.

johannes
