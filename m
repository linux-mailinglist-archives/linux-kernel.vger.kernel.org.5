Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44A7D9AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbjJ0OEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346058AbjJ0OEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:04:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654DFC0;
        Fri, 27 Oct 2023 07:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79480C433C8;
        Fri, 27 Oct 2023 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698415449;
        bh=zb7VOvv5is8TXMsO8sefQ6eAL5YvHQLdJ+7pq0MU95E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oOOJG8kLy2ldsZdK6ka8h8Igbkkz6/Ls/YGOMzkmNQmFyHlVlyWX7JByU2ItRTF+k
         Of+wNX4qK7MC7hkw+5e8QgFTKYv9SAJxxMqzpZt3rjzlHXK8FLRp6dWABdndgRUkhU
         DOW9vzohYVifieynkObabH0wNTQymUdh5+TPavOOoYxf64NbiNuf8XE0nBJgkvgL/O
         SnmicyONzOe5s0Lsu/S393nvY2DfbPwE7Zgoho9wUgwzyqujLb3ZDBiba0EVCP6hxF
         S6YtgWuQu7TBgmf8Y8cZOc0HOvFSdJnviJ8mhN9XdW2e/F/hEK2B6PphClMXEJV0Yr
         QgvNM6aLdKUxg==
Date:   Fri, 27 Oct 2023 15:03:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: imu: Fix spelling mistake "accelrometer" ->
 "accelerometer"
Message-ID: <20231027150333.2bc7bf8d@jic23-huawei>
In-Reply-To: <CAM+2EuK2LOL=g=r866c6zwE4XOSL5uZ-rweUjm6svgSi8v9Xkw@mail.gmail.com>
References: <20231023081054.617292-1-colin.i.king@gmail.com>
        <CAM+2EuK2LOL=g=r866c6zwE4XOSL5uZ-rweUjm6svgSi8v9Xkw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 16:37:01 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> On Mon, Oct 23, 2023 at 1:40=E2=80=AFPM Colin Ian King <colin.i.king@gmai=
l.com> wrote:
> >
> > There are two spelling mistakes in dev_err messages. Fix them. =20
>=20
> Hi Colin,
>=20
> Thanks for fixing this.
> Reviewed-by: Jagath Jog J <jagathjog1996@gmail.com>
>=20
Applied. thanks,
