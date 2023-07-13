Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D445751F74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGMLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjGMLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:05:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2C211E;
        Thu, 13 Jul 2023 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fIgDmYcoJkd7PIFdP4hS9xlcqxhxEOoDJGq8m/+LNS4=;
        t=1689246352; x=1690455952; b=doIBk7MGZgnTTJV7nIYLFuwpy+bCHNt1nRywQsnp9LIleqg
        jROGJwzAEdJUzdpG5X2UegUpurOmpC6KyJ43MVrMA+EtsH7WZfYpkvPK68ZtAEm+AjBoNEZDNH8gq
        R5DHP1cKM7yo4smrRYaiQLPApg5FGwSbqOc8Otyc/ix2kGfI9IEz07Y5RTXUz4ZeGxSUpn9Q9kzoQ
        sMzfdBuK8XcSACFdGPjX9LtuWhNYPPM6++OIIQp7xamAk9lFcay6GJjM46eW6kv+y/L1fsX9HN4AT
        dDmCUwyrq7azMEEmt5m8q8FShoIMpB9DWx/Q9Z7OQD+j18MU4ibrcC4V9XUgKoLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJu8p-001Df9-0b;
        Thu, 13 Jul 2023 13:05:47 +0200
Message-ID: <d1f9ca04bb055dc07f2a7f9f07f774e08913cf00.camel@sipsolutions.net>
Subject: Re: Closing down the wireless trees for a summer break?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>
Date:   Thu, 13 Jul 2023 13:05:45 +0200
In-Reply-To: <87wmz43xy4.fsf@kernel.org>
References: <87y1kncuh4.fsf@kernel.org>
         <ZK7Yzd0VvblA3ONU@smile.fi.intel.com> <87wmz43xy4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-13 at 13:30 +0300, Kalle Valo wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
>=20
> > On Tue, Jun 13, 2023 at 05:22:47PM +0300, Kalle Valo wrote:
> >=20
> > ...
> >=20
> > > [1] https://phb-crystal-ball.sipsolutions.net/
> >=20
> > How could one use the shut down site?
>=20
> What do you mean? At least from Finland it Works for me:

That did in fact not work yesterday for some time as I was doing some
maintenance :)

johannes
