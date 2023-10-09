Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778E7BE53C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377844AbjJIPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377815AbjJIPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:44:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BCE9C;
        Mon,  9 Oct 2023 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696866259; x=1697471059; i=rwarsow@gmx.de;
 bh=wU2sViw4lLhfaQMAPdCpZMbwFG7nuzOCnATMctATWtQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=nic1fbnNX39//ap6+37IiyxTXIqzeymW9t/PThNs0NMjV2YRL3tPI2oBSsp6ZYCwxf+zu1Ray7R
 sOQKZWm7StoyxEisUHvI1k+wtkIw+qXnWdpEnIRFsccVdd+TBIYBQP19n4Ui3UwVbqZVrOAUm5DE3
 L6TRMvtJJsGX1s52Sn+QOdHxLGrNoAkqAmlO6ZWuV/5CB9WUbjUkLMtQWXs9xoqboibQ6m4JUpqiG
 GNCUyGRWylQsx9fX90W6pNEblJ3t53tXI66trGL4+9Q1EsZEW3TPq7IbRJa0JhStVLwdHD9IcRGRm
 fIzv88VLOftwTyx/TOcIZVxDQqGTz8ikgs/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.199]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1rTJNU0zyR-00fkyb; Mon, 09
 Oct 2023 17:44:19 +0200
Message-ID: <45a9f9ea-f828-41cd-8447-85e227457293@gmx.de>
Date:   Mon, 9 Oct 2023 17:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:36YCFZl/QmG8pGN7o9FReqEUBEqETwoS3yC0l0yG3VmfUa03hQS
 L35gYbreUpoGO/2U6tra2ZXIiC3EE+PbUTEPdsmEJ2ACgbml1tb78lNA0jPxHeNuZEu0Pa/
 DYJHj3v0CeyQkhNHW6bPvgaWqBEfIYNEZSGZtjl+7iYO9QGWOgffzC1WHbIoelC9fMqWwVQ
 PzROnzgfWCdGYOv6Rt5Tg==
UI-OutboundReport: notjunk:1;M01:P0:CCEDjuKf85o=;MuyV9BX++sjvIsz4TUp3aIfFqe3
 K5+okWiQg5Bijr7gFQ9XDM+heEGfGHMhq2PzqnNrj+ue0KbmX/Paydq6Hwq2cMF0HupC8shik
 vzkP8QQQ/M8YkRllMbTIdLn4JtHCzWSLR/8/XmrqeJuLvfIEdV4UP/PoLdxPwnW7/mcanVzk5
 ZLauIHykQ550oWWmrHprYcN0nGMuk9E4F7QC6S8NyH5ov8A3IcTEzsxN7tFvisnipkF2iWo2x
 MbVB4R5/luZf71IWhmcyYPjEjD/yrgRY7WQpj6laKNv5iozrclgRkxJ9k4Ps7N0EbkYLHnTHZ
 DbcCrz05OleHGyGWW8UjKW6wrnxMknth0SwTpZ9K7Aj9cPGahJcT8wGP3RvT2DxFHKfWx7w/e
 LqPvawNdtCnDCEInFImbJxnWgqxzLt8FKTywsUGtYBBvLH7xfutYbL7qv/I3vHaPAroM0Ih1O
 SX2nt82bCu/3QW/b9N9FHebrVuoIZCR3zqXCX0AymGE+FTeayA23ciqvK3zEFXwhz+8LNk8pl
 bhNhosyBPxTAxT4T/MBeM6Ng0iGzEQ4iCPlvUtBNtqJFbVJoFaTKuoxp0t2kR27A5CcWhIi0k
 oOiDqPePNmXnIAg1w6cpgbMHre+71y/Hue6si5MckeHKL0uaHCvQyR5tLkkVherOgd5d4TUt8
 mornYKXBpM/o4EvL6JocghmZxYdPbaxBQNQxgRvWmbS3z1pB4PlLHjDfBbajuYRAMXVpKKl3Q
 gS8dK4L2vfxU8bXvRlo0Kp1fmRB9VmUsXKGPXL4ATaJN0J16tcGkeDkdgS6Pcn3cTZMBtHZ7j
 +gEjTKqH48hOBk3Vledfot1yOxjyM8THaKrrhDSwcmi+E5LG1uow3JZA9qbj/rjfRH5O5zpve
 biU+ZnsAS+EY5A2DKCAXMb14+HUHeUYepZMLSn/GAw3LSQiBmSvzIZ4x6orxeBIQVlyGhzrfR
 FAtKuayWfyeYBic4B/RnMNmkmRY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.5.7-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

