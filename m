Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8C7E5F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjKHU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:26:57 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB82126;
        Wed,  8 Nov 2023 12:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1699475208; x=1700080008; i=smoch@web.de;
        bh=ZACOxEiiky6QlKBXcR4VMWP5DrXmXLtC0YbGjfuX9Lw=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=p8zT4WuzWW82iH+3l1dXL8L9UNCZZ/Enf1t/G5HVuv2QYJCoZEuTxLxWEQjlsPyf
         tqTEyaGJc7DK0mE7Rry+EoYBUOHhkOy968CqbCRoraUyDfd2LouogZzAqaYwZcjUA
         vMCW1mqrxl9BhLXFXjfTFL//pl5+2M/dCqhMJ1YVdV5VcGOa9dRzd+ITDbtaXViSK
         5xVwgrdMw4v1eoUhFO5Vh6Go/5jej2MwL1UrdRlX8YI9LGlOgsVwzwpsYE3RUClTG
         Dn0h+L+JfqEQUrjQ+6b7VjsK7Ktipc0S6A84X/D+nZ5XmIaxoNC8KL8EM/jao4Lvq
         NmFNvJQPSiAz8BmJPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1rNjJD3gLk-00wISS; Wed, 08
 Nov 2023 21:26:48 +0100
Message-ID: <5f016e90-9ce4-440b-b488-f9c103729e01@web.de>
Date:   Wed, 8 Nov 2023 21:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Jes Sorensen <Jes.Sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Soeren Moch <smoch@web.de>
Subject: RTL8XXXU_UNTESTED
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E3rlQkP2AHAa4LeGfWA34fs/LXuJObYGvMzr6jwA2ghhqAI7Oy8
 8PD1gVHn2DCBUZfblgIczoOWP+gfQjd4G2jY3seimflnwIc7irwEhoNoMq+C3mfFsmksaLq
 3h+bHPdZg6BDhHbnR9keebjDriJumR2DFRyRkBznWgzkjpeBA+8DIer6mTTd+aUfFYwbABt
 W3NgQ/zcXTe3gekwpjezQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E+ZegCu1beY=;wOHG+ZI3UeiLpIrTGpf4mig9waG
 ibF9kXO1028iWVdLFWzTuRUx/3iVcSjk5rbUk6yY6HxyfKYF+MSErg+xmSNDuKGv2jzC4d5t3
 ETMsjiCfWSksj1dmvC0s6Ctjg4Ab2eyq6pPnWtUO/mA6Cq77X7KxdJgV/AluNJisUmkQtk98u
 e1FEhqGyVgddgugZFyhFzaEg3ceNGlfVLsTpbLqBgluzUIQT9Eo6G1XVgDSWJj3fSOsmUmmo0
 ko4eGZ9S48uJpXHJWL5muBPDEdls2h20Fzv0zx02PuCeeyaYFKSdnts2I63AMn6J9VSKvvQrX
 YVh8HXZXZziuz9zNRpeRu4d+AgKqpgXO504apPQMe/E1lUQnnoyOc55LnEy22G9Wiq2CJyven
 NRO3nh1+6672WsRFeFC1Q1ZmkcQLl9gvKtWYb/v6jsqtm8Xv1ZA73XFx0TQbiFNnBM1mmfpjF
 wL0mIfhfp+HAwHJOFl9wI3gI3Vpxw8Exzhb9x6uKle5IQ6Kx3ou09mTuWb5xCgo00VY6f3nUV
 woRGV8GGH90LalkBu4r+5QV7Oii1LM/UEz20dKUY7ML4nTuwdrNdSqLX/03B+aEQ6HFQuYmR4
 syS464abXoU6O9aiov6M/TlrlVNqCkB+4QNVFZPGPf+jLrCLJttPaQH+vlc2gwkXA6vYdsavN
 ByPSQoH+UHvUX9hnhYe7QUAEGio4KLVgiouyr2eMo2/OlR5xi95WqLnUJTkgndnzAjEPLnJRO
 pdGn7Ef414CmSx8NYnF3NUR/7Xf/+PcX4S/LI7UDBaNk8y+svCzHmGusDRr2B2ChpJWiq5PR/
 vnjuk5EkVk/HngZz/1Z5Yzqy0aqVWrG+m17c99BqhZO1JquS4A001s8oIcWKnpuxCD0CuNRfF
 d4hPz8eneAg91xEtKmSzet35aBRNq3QeOPFaclYxT3ccrKM+WlMbHjSR1ZBOWts9rtatpHnJi
 nAflPJekyXmshP6tjTrYcPDbwlo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As response to the test and report request for the RTL8XXXU_UNTESTED
configuration option:
I successfully tested the rtl8xxxu driver in linux-6.6.1 with following
device:

Bus 002 Device 003: ID 0bda:8179 Realtek Semiconductor Corp. RTL8188EUS
802.11n Wireless Network Adapter

probe messages:
[=C2=A0=C2=A0=C2=A0 5.207659] usb 2-1.1: RTL8188EU rev D (TSMC) romver 0, =
1T1R, TX
queues 2, WiFi=3D1, BT=3D0, GPS=3D0, HI PA=3D0
[=C2=A0=C2=A0=C2=A0 5.217356] usb 2-1.1: RTL8188EU MAC: 00:33:0e:00:15:53
[=C2=A0=C2=A0=C2=A0 5.222674] usb 2-1.1: rtl8xxxu: Loading firmware rtlwif=
i/rtl8188eufw.bin
[=C2=A0=C2=A0=C2=A0 5.234689] usb 2-1.1: Firmware revision 11.1 (signature=
 0x88e1)

Thanks for maintaining this driver,
Soeren
