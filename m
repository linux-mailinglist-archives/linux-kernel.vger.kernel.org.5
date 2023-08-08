Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4E774D89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHHV61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjHHV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:58:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE63BCE9;
        Tue,  8 Aug 2023 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wmjALgSpJxBpxWaC9pnbXCbGaVcndbuceuZjWcVcT9A=;
        t=1691512841; x=1692722441; b=MkCKvNWmNejCpXqk0PVtAvWmjsxR1nGYvMxMO50KBsJce9f
        6Vm+M6YDo6xK5i6I0IG1dL70l4l6LISWPY2fbeiSMC4RMnRULo/fD1Vhq3JibjZpfu0cZeEfqve2F
        hqmtVSWR4X9L6UyGNNrSC+llkua+nzZLmBv6tm/70pIZTi2DsMXETy7KiDxiUTkhMJTTfBafZcGBt
        Q0CHMyXBz8kdiBQMOIno17klm76vh8l4Bjm9Yyra7XEvNkCtekW/9sW2yQ89z4XHN1fY771MRHDL0
        kzFaOzI2Hsne3zE+WeqYCIu/0cQe8EsriSoiPcY78cY8E+jqV8DEyJz4YVxr+bfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTIGs-00CS1A-2W;
        Tue, 08 Aug 2023 10:40:55 +0200
Message-ID: <bed853f70773496902b5676e568922edbf487dfb.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: ralink: rt2x00: "foo* bar" should be
 "foo *bar"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     hanyu001@208suo.com, stf_xl@wp.pl, helmut.schaa@googlemail.com,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Aug 2023 10:40:53 +0200
In-Reply-To: <36e36d94e81da4342283aac471fb5a7bd3eb9f65.camel@sipsolutions.net>
References: <tencent_316424AFC531C5F050C0203FDBA08E84F907@qq.com>
         <18520fa625b8a901314c65bb8e557091@208suo.com>
         <36e36d94e81da4342283aac471fb5a7bd3eb9f65.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-08 at 10:34 +0200, Johannes Berg wrote:
> On Fri, 2023-07-21 at 14:34 +0800, hanyu001@208suo.com wrote:
> > Fix checkpatch warnings:
> >=20
> > ./drivers/net/wireless/ralink/rt2x00/rt2x00.h:386: ERROR: "foo* bar"=
=20
> > should be "foo *bar"
> > ./drivers/net/wireless/ralink/rt2x00/rt2x00.h:513: ERROR: "foo* bar"=
=20
> > should be "foo *bar"
> >=20
> > Signed-off-by: Yu Han <hanyu001@208suo.com>
>=20
> This patch is broken. I'll just point you to what I wrote before:
>=20
> https://lore.kernel.org/all/058dd31ef48495f8641f5b66839aaea039af0f08.came=
l@sipsolutions.net/
>=20
> What _are_ you trying to achieve?!
>=20
> Currently all you're achieving is annoying everyone with broken (and
> pointless submissions).
>=20

And the email address doesn't even work, only about two weeks after you
sent this patch?

  hanyu001@208suo.com
    host mx1.qiye.aliyun.com [47.246.146.58]
    SMTP error from remote mail server after RCPT TO:<hanyu001@208suo.com>:
    554 RCPT (hanyu001@208suo.com) dosn't exist

johannes
