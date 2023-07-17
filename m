Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA1755C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGQHEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGQHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:04:54 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1AF02F0;
        Mon, 17 Jul 2023 00:04:51 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 0A497601A1674;
        Mon, 17 Jul 2023 15:04:49 +0800 (CST)
Message-ID: <29e3ea89-db2c-0b54-4af1-d8098f011a9e@nfschina.com>
Date:   Mon, 17 Jul 2023 15:04:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next v3 8/9] can: ems_pci: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <20230717-staple-uninjured-26bfd8cde5e0-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/17 14:52, Marc Kleine-Budde wrote:
> On 17.07.2023 11:12:21, Wu Yunchuan wrote:
>> No need cast (void*) to (struct ems_pci_card *).
>>
>> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
>> Acked-by: Marc Kleine-Budde<mkl@pengutronix.de>
> Please add a space between my name and my e-mail address, so that it
> reads:
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Hi,

Sorry for this, I will resend this patch to add a space.
>
> nitpick:
> You should add your S-o-b as the last trailer.

Oh, thanks for this reminder!

Wu Yunchuan

> regards,
> Marc
>
