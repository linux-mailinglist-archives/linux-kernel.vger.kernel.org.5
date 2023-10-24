Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9B7D48C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjJXHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjJXHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:40:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3EB7;
        Tue, 24 Oct 2023 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wDdZe1ccmDlYEf7VbnHjWqpDq2mjMLwOKz8KmLSioHo=;
        t=1698133248; x=1699342848; b=Gl7KKMp0/2fbMdEI06eSLpDgullckzYiFaDvSwo9zirYEB8
        AGu5CMj5/EaI9eRCv+pP4/XLq68tY52rGnAWQJO2X3IcOQGJf3NKnTH/ykwWh4Kl0hNmnoJy019N3
        3Jxg1zepg2E6OMI7uv3YWXtXi/1sHRjF+JnUySi8LIwKMaMzYGNbeea1YcuTkrikrldmkDQLoh+B4
        eYDIZKSZm6qCANGEPgMHXh1IH/a4C7lzfBe+EhGYKsaigP4I2AMdWG8z657ZixF7oQZI7t/IZO97K
        gaiiVStt850HFiyVbiEQZinMdsnlJvV43DHqtrZ8ZLD8/8ifgCEDY7WLR3AWQ7Uw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvC1s-00000001IKI-3VUL;
        Tue, 24 Oct 2023 09:40:45 +0200
Message-ID: <3a68f9ff27d9c82a038aea6acfb39848d0b31842.camel@sipsolutions.net>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
Date:   Tue, 24 Oct 2023 09:40:43 +0200
In-Reply-To: <20231023185221.2eb7cb38@kernel.org>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
         <20231023032905.22515-3-bagasdotme@gmail.com>
         <20231023093837.49c7cb35@kernel.org>
         <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
         <20231023185221.2eb7cb38@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 18:52 -0700, Jakub Kicinski wrote:
>=20
> > He's now in a state of limbo. He has significant contribution
> > (and gets listed by get_maintainer script with (AFAIK) no way
> > to filter him out), yet emails to him bounces. What will be
> > the resolution then?
>=20
> Yes :( Not much we can do about that (even if we drop him from
> maintainers all fixes will CC him based on the sign-off tags).

I was hoping he'd chime in here - I did manage to find him at his
personal address, but I didn't want to just add his personal address to
the public list.

If he's OK with exposing his personal (or new work?) address I guess we
could add him to the .mailmap, to address this particular problem.

Anyway I've BCC'ed him now (Hi Chetan :) ), but he had also said he was
checking with his new work about this all.

johannes
